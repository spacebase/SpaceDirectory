<?php



namespace Drupal\spacebase_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides the sidebar Profile Block for group/x/[discusssions|resources|etc
 *
 * Not every group/x/something gets this nav bar, tbd.
 *
 * @Block(
 *  id = "org_profile_block",
 *  admin_label = @Translation("Org profile block"),
 *  category = @Translation("Extending Group Module")
 * )
 */
class OrgProfileBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    return array(
      '#markup' => $this->t('Hello, World!'),
      '#theme' => 'org_profile_sidebar',
    );
  }

}

/* @ToDo: here is boilerplate for figuring out the cache issues later.

 See this:
https://drupal.stackexchange.com/questions/199527/how-do-i-correctly-setup-caching-for-my-custom-block-showing-content-depending-o

public function getCacheTags() {
  //With this when your node change your block will rebuild
  if ($node = \Drupal::routeMatch()->getParameter('node')) {
    //if there is node add its cachetag @ToDo
    return Cache::mergeTags(parent::getCacheTags(), array('node:' . $node->id()));
  } else {
    //Return default tags instead.
    return parent::getCacheTags();
  }
}

public function getCacheContexts() {
  //Depends on \Drupal::routeMatch()
  //Every new route this block will rebuild.
  // @ToDo. This is too many rebuilts. group/5/variable
  // can cache group/5
  return Cache::mergeContexts(parent::getCacheContexts(), array('route'));
}
 */
