## SpaceDirectory

SpaceDirectory is an Open-Source directory based on <a href="https://spacebase.co">Spacebase.co</a>. SpaceBase is a directory of local content, regional data, projects, and reports. 

SpaceDirectory is built with Drupal 8, using composer, largely built around the Group module. This repository will help you get SpaceDirectory up using Circle CI, Lando and Pantheon. The code is not locked to Pantheon, GitHub or CircleCI — SpaceBase started with GitLab, Platform.sh and Lando.

To set up using Pantheon, this repository should be cloned using Terminus and not `git clone.` 

A linux-hosted demo: http://demo1.spacebase.co/


## Quick Start - Make a demo site on Pantheon

### Step 1: Create accounts and get access tokens.

Follow this document precisely until you get to the point where you have access tokens:

https://pantheon.io/docs/guides/build-tools#before-you-begin  [should probably backup that document in case it changes...]

Make sure to install Composer globally rather than locally, otherwise you'll run into errors later.


### Step 2: Add the access tokens to your current local environment

Replace the your-thing strings with your tokens and sitename and run the following (NOTE: Pantheon doesn't allow capital letters in the SITENAME. Also, your sitename has to be unique on all of Pantheon.):

```
export GITHUB_TOKEN=yourtoken`
export CIRCLE_TOKEN=yourtoken`
export SITENAME=choose-your-sitename`
```

### Step 3: Use `terminus` to clone our repository onto Pantheon so you can launch your Drupal site.

Before you run terminus, verify that you are set up to use the correct accounts:

`terminus auth:login`
`terminus auth:whoami`

Run exactly this terminus command:

`terminus build:project:create --stability dev spacebase/SpaceDirectory $SITENAME 2>&1 | tee terminuslog.txt`

*[ Note: We can hack the terminus program to keep the git history. Get the version of terminus stephen is using, then add `--preserve-local-repository`to above command. Solution is still under consideration.]*

**That command should do a lot:** creates a new GitHub repository and a new Pantheon demo site, integrated by CircleCI.

Visit CircleCI - you should have a workflow now.
Visit Github.com - you should have a repo with your sitename
Visit Dashboard.pantheon.io - you should have a new pantheon site (unless you ran out of sandboxes)

If you don't have all of those, read through terminuslog.txt to find where things went sideways, or run it again with option  `-vvv` to get more debug info.

The last lines of text should point you at your new github repository.

### Step 4: Load the database at Pantheon and start using Drupal [ Easy Drupal ]

We have a demo database here:
http://demo1.spacebase.co/dumpfile_less_content.sql
@ToDy: further prep demo1 content.

Import our database either in in Pantheon panel, or try terminus (we had problems w/ command line):
`terminus import:database $SITENAME.dev http://demo1.spacebase.co/dumpfile_less_content.sql`

Possibly useful commands:
`terminus drush $SITENAME.dev cr`
`terminus drush $SITENAME.dev uli`
`terminus drush $SITENAME.dev updatedb`

You’ve now got your working copy of the SpaceBase distribution.

Since our database is likely a bit dated, you might want to set up your local dev environment and run composer update. Detailed instructs in the 'Lando' section
below, which can act as a tutorial for other development work.

The top of the README.md on Github should have your CircleCI, Pantheon dashboard and site (“dev” at Pantheon, use Pantheon tools to make it live.)



And that's the quick start! Even more notes available on the [wiki](https://github.com/spacebase/SpaceDirectory/wiki)


