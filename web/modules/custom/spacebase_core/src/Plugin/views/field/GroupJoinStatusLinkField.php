<?php

namespace Drupal\spacebase_core\Plugin\views\field;

use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Url;
use Drupal\Component\Utility\Random;
use Drupal\views\Plugin\views\field\FieldPluginBase;
use Drupal\views\ResultRow;

/**
 * A handler to provide a field that is completely custom by the administrator.
 *
 * @ingroup views_field_handlers
 *
 * @ViewsField("group_join_status_link_field")
 */
class GroupJoinStatusLinkField extends FieldPluginBase {

  /**
   * {@inheritdoc}
   */
  public function usesGroupBy() {
    return FALSE;
  }

  /**
   * {@inheritdoc}
   */
  public function query() {
    // Do nothing -- to override the parent query.
  }

  /**
   * {@inheritdoc}
   */
  protected function defineOptions() {
    $options = parent::defineOptions();

    $options['hide_alter_empty'] = ['default' => FALSE];
    return $options;
  }

  /**
   * {@inheritdoc}
   */
  public function buildOptionsForm(&$form, FormStateInterface $form_state) {
    parent::buildOptionsForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function render(ResultRow $values) {
    $output = '';
    $entity = $values->_object->getValue();
    if ($entity->getEntityTypeId() == "group") {
      $account = \Drupal::currentUser();
      $membership = $entity->getMember($account);
      if (!$membership) {
        return [
         '#markup' => '<a href="/group/' . $entity->id() . '/join" class="btn btn-success">join</a>',
        ];
      }
      else {
        $roles = $membership->getRoles();
        if (isset($roles['organization_group-verified']) || isset($roles['organization_group-admin'])) {
          return [
            '#markup' => '<span class="text-success">member</span>',
          ];
        }
        else {
          return [
            '#markup' => '<span class="label label-default">join requested</span>',
          ];
        }
      }
    }

    return $output;
  }
}
