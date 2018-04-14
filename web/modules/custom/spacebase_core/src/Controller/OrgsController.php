<?php

namespace Drupal\spacebase_core\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

/**
 * Class OrgsController.
 */
class OrgsController extends ControllerBase {
  
  // The resources page was basically built in Twig Tweak,
  // so currently there's not much happening here.
  // Expect that to change a bit once design (currently not really
  // spec'd!) settles down, move more code here.
  public function resources($group) {
    // We're reaching here. It does throw AccessDenied. It then
    // shows the page. The breakpoint doesn't work here.
    //die($group); group is 16 as expected.
    if (!is_numeric($group)) {
      // We will just show a standard "access denied" page in this case.
      // @ToDo: this doesn't really work in intial effort
      throw new AccessDeniedHttpException();
    }
    $build = [
      '#theme' => 'group_resources', // this is the theme hook
      '#group_id' => $group,
      // resource_type was previously provided to the group's homepage
      // with an alter, @ToDo = is that still needed? Might be.
      '#resource_type' =>  _get_resource_type(),
    ];
    // Need some of what comes from preprocess groups.
    // @ToDo: cut and pasted from existing code... figure out real plan
    // @ToDo: fix that group is used as group and group->id(), overwritten
    $account = \Drupal::currentUser();
    $plugin_id = 'resources';
    $build['#group_links'] = [];
    $group = \Drupal\group\Entity\Group::load($group);
    if ($group->hasPermission("create $plugin_id entity", $account)) {
      $route_params = ['group' => $group->id(), 'plugin_id' => $plugin_id];
      $url = new \Drupal\Core\Url('entity.group_content.create_form', $route_params);
      $build['#group_links']['group_create_'. $plugin_id] =
        $url->toString() . '?destination=/group/' . $group->id();

    }
    return $build;

  }
}
