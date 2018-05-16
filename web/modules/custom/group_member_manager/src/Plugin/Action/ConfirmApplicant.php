<?php

namespace Drupal\group_member_manager\Plugin\Action;

use Drupal\Core\Action\ActionBase;
use Drupal\Core\Session\AccountInterface;
use Drupal\views_bulk_operations\Action\ViewsBulkOperationsActionBase;

/**
 * Provides a 'ConfirmApplicant' action.
 *
 * @Action(
 *  id = "applicant_confirm",
 *  label = @Translation("Confirm Applicant"),
 *  type = "",
 * )
 */


/* type is the group module's version of a user,  'group_content' not a user, @ToDo */

class ConfirmApplicant extends ViewsBulkOperationsActionBase {

  //use Drupal\Core\StringTranslation\StringTranslationTrait;

  /**
   * {@inheritdoc}
   */
  public function execute($group_content_membership = NULL) {
    // entity is a $group_content.
    $gcid = $group_content_membership->id(); // group_content
    $config = $this->getConfiguration();
    // Get the radio button that matches the entity's id:
    foreach ($config['id-action'] as $id => $action) {
      if ($gcid == $id) {
        if ($action == 'reject') {
          // reject this member: just delete the group_content, I think.
          // I think the $group_content is exactly what makes this user a member,
          // so just delete it? That simple?
          $group_content_membership->delete();
          // FINISHED: Action processing results: Still pending: 118 (1), Reject this one: 120 (1).

          return "Rejected " . $group_content_membership->label();

        } elseif ($action == 'confirm') {
          // And add the role 'verified' (internal-facing name only)
          // As we move forward, only verified members count as anything, whenever membership
          // permissions are considered. This is a bit of a mess, evolving from specs that
          // didn't differentiate... Groups module does not have pending for D8, though it's being
          // worked on.
          $group_content_membership->group_roles->setValue('organization_group-verified');
          $group_content_membership->save(); // returns 2, SAVED_UPDATED, if working. Add test?
          return "Accepted " . $group_content_membership->label();
        } else {
          return $group_content_membership->label() . " still pending";
        }
      }
    }

    // @ToDo: get t workiong
    //return $this->t('Confirm this user - not built yet');
    return "Tried to execute Confirm Applicant";
  }

  /**
   * {@inheritdoc}
   */
  public function access($object, AccountInterface $account = NULL, $return_as_object = FALSE) {
    return true; /* @ToDo     Did this ever work? Keep going on radios for now */
    $access = $object->status->access('edit', $account, TRUE)
      ->andIf($object->access('update', $account, TRUE));

    return $return_as_object ? $access : $access->isAllowed();
  }

}
