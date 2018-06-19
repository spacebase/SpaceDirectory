<?php

namespace Drupal\spacebase_orgs;

class MemberManager {

  public static function rejectMembership($id, &$context){
    $context['sandbox']['progress']++;
    $membership = \Drupal::entityTypeManager()->getStorage('group_content')->load($id);
    MemberManager::notifyStatus('membership_rejected', $membership);
    $membership->delete();
    $context['message'] = "Rejected {$membership->label->value}";
    $context['results'][] = $id;
  }

  public static function approveMembership($id, $admin = FALSE, &$context){
    $membership = \Drupal::entityTypeManager()->getStorage('group_content')->load($id);
    $context['sandbox']['progress']++;
    $membership->group_roles->setValue('organization_group-verified');
    if ($admin) {
      $membership->group_roles->setValue(['organization_group-admin','organization_group-verified']);
    }
    if ( $membership->save() == 2 ) {
      MemberManager::notifyStatus('membership_approved', $membership);
    }
    $context['message'] = "Approved {$membership->label->value}";
    $context['results'][] = $id;
  }

  public static function notifyStatus($key, $membership) {
    $account = \Drupal\user\Entity\User::load($membership->uid->target_id);
    $params = [
      'account' => $account,
      'group' => $membership->getGroup(),
    ];
    spacebase_orgs_send_email($key, $params);
  }

  public static function moderateMembershipFinishedCallback($success, $results, $operations) {
    $message = t('Finished with an error.');
    if ($success) {
      $message = \Drupal::translation()->formatPlural(count($results), 'One membership processed.', '@count memberships processed.');
    }
    drupal_set_message($message);
  }
}