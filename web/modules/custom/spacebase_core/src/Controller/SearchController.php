<?php

namespace Drupal\spacebase_core\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Class SearchController.
 */
class SearchController extends ControllerBase {

  /**
   * Search.
   *
   * @return string
   *   Return Hello string.
   */
  public function search() {

    $return = [
      '#theme' => 'sb_search_page',
      '#keywords' => $_GET['keywords'] ?: '',
    ];

    // @TODO I'm not a huge fan of this since its running the query twice.
    $return['#org_count'] = $this->searchResults(['entity:group'], TRUE);
    $return['#orgs'] = $this->searchResults(['entity:group']);
    $return['#people_count'] = $this->searchResults(['entity:user'], TRUE);
    $return['#people'] = $this->searchResults(['entity:user']);
    return $return;
  }

  private function searchResults($args, $count = FALSE) {
    $view = \Drupal\views\Views::getView('sitewide_search');
    $view->setDisplay('search');
    $view->setArguments($args);

    $view->setItemsPerPage(3);
    if ($count) {
      $view->setItemsPerPage(0);
    }

    $view->preExecute();
    $view->execute();

    if ($count) {
      return count($view->result);
    }

    return $view->render();
  }

}
