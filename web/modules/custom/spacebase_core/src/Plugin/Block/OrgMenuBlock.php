<?php

namespace Drupal\spacebase_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;

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

    $path = explode('/',\Drupal::service('path.current')->getPath());
    $build['#gid'] = intval($path[2]);
    $a = $path[3];
    $active = [];
    $active[$a] = 'active';    // @ToDo standdardize?
    $build['#active'] = $active;
    return $build;
  }
}
