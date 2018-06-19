<?php

namespace Drupal\spacebase_orgs\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormInterface;

/**
 * Provides a 'OrgPendingMembersBlock' block.
 *
 * @Block(
 *  id = "org_pending_members_block",
 *  admin_label = @Translation("Pending Members"),
 * )
 */
class OrgPendingMembersBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $form = \Drupal::formBuilder()->getForm('Drupal\spacebase_orgs\Form\OrgPendingMembersForm');
    return $form;
  }

}
