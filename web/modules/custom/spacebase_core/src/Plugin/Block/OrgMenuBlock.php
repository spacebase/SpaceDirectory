<?php

namespace Drupal\spacebase_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\group\Entity\GroupContent;
use Drupal\node\Entity\Node;

/**
 * Provides a 'OrgMenuBlock' block.
 *
 * @Block(
 *  id = "org_menu_block",
 *  admin_label = @Translation("Org menu block"),
 * )
 */
class OrgMenuBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $build = [];
    $build['#theme'] = 'menu_org_profile';

    // These pages have either a group/gid or node/nid, from which we'll need
    // the group.
    $path = explode('/',\Drupal::service('path.current')->getPath());
    if ($path[1] == 'group') {
      $gid =  intval($path[2]);
    } else {
      $nid = $path[2];
      $node = Node::load($nid);
      $group_content = array_shift(GroupContent::loadByEntity($node));
      $group = $group_content->getGroup(); // on null
      $gid  =  $group->id();
    }
    $build['#gid'] = $gid;
    $a = $path[3];
    $active = [];
    $active[$a] = 'active';    // @ToDo standdardize?
    $build['#active'] = $active;
    return $build;
  }
}
