From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 9 Feb 2018 14:37:00 +0000
Subject: [cip-dev] How to develop on the RT version
Message-ID: <SG2PR06MB1165F30CAFCC145F81AE021E8AF20@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello CIP members,

As I look at the git repository, there are multiple PREEMPT_RT branches:

 * linux-4.4.y-cip-rt-rebase
 * linux-4.4.y-cip-rt
 * linux-4.4.y-cip-rt-patches

I'm trying to understand if I want to develop a product using RT, what branch should I be tracking and pulling into my local git repo?


I would think that locally, I would have some git repository that I will pull from CIP and merge into my own tree. I would also be pushing that to some local server to share with the other team members in my group.

Therefore, the 'rebase' thing doesn't make sense to me because if you are pushing a rebased tree, that means you are changing the existing parent history and doing a simple 'git pull' doesn't work so well (like what you have with the linux-next tree).


Do I just fetch and merge from 'linux-4.4.y-cip-rt' periodically as I develop my product, and that will play nicely with the local commits that I am also making and pushing locally to my repository?

Thank you,
Chris
