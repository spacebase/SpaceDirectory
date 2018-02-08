<?php

namespace Drupal\spacebase_core\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Class SearchController.
 */
class SearchController extends ControllerBase {

  public function search() {
    $return = $this->searchReturn() + [
      'fullpage' => FALSE,
    ];

    // @TODO I'm not a huge fan of this since its running the query twice.
    $return['#org_count'] = $this->searchResults(['entity:group'], 0,TRUE);
    $return['#orgs'] = $this->searchResults(['entity:group']);
    $return['#people_count'] = $this->searchResults(['entity:user'], 0,TRUE);
    $return['#people'] = $this->searchResults(['entity:user']);
    return $return;
  }

  public function searchPeople() {
    $return = $this->searchReturn();
    $return['#people_count'] = $this->searchResults(['entity:user'], 0, TRUE);
    $return['#people'] = $this->searchResults(['entity:user'], 10);
    return $return;
  }

  public function searchOrganizations() {
    $return = $this->searchReturn();
    $return['#org_count'] = $this->searchResults(['entity:group'],0, TRUE);
    $return['#orgs'] = $this->searchResults(['entity:group'], 10);
    return $return;
  }

  private function searchReturn() {
    return [
      '#theme' => 'sb_search_page',
      '#keywords' => $_GET['keywords'] ?: '',
      'fullpage' => TRUE,
    ];
  }

  private function searchResults($args, $items_per_page = 3, $count = FALSE) {
    $view = \Drupal\views\Views::getView('sitewide_search');
    $view->setDisplay('search');
    $view->setArguments($args);

    if ($items_per_page <= 3) {
      $view->pager = new \Drupal\views\Plugin\views\pager\None([], '', []);
      $view->pager->init($view, $view->display_handler);
    }

    $view->setItemsPerPage($items_per_page);

    $view->preExecute();
    $view->execute();

    if ($count) {
      return count($view->result);
    }

    return $view->render();
  }

}
