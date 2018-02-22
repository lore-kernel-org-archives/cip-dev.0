From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 22 Feb 2018 11:19:15 +0900
Subject: [cip-dev] How to develop on the RT version
In-Reply-To: <SG2PR06MB1165F30CAFCC145F81AE021E8AF20@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB1165F30CAFCC145F81AE021E8AF20@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <001f01d3ab83$89b7b5a0$9d2720e0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Chris Brandt
> Sent: Friday, February 09, 2018 11:37 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] How to develop on the RT version
> 
> Hello CIP members,
> 
> As I look at the git repository, there are multiple PREEMPT_RT branches:
> 
>  * linux-4.4.y-cip-rt-rebase
>  * linux-4.4.y-cip-rt
>  * linux-4.4.y-cip-rt-patches
> 
> I'm trying to understand if I want to develop a product using RT, what branch should I be tracking and pulling into my local git repo?

This one: linux-4.4.y-cip-rt

> I would think that locally, I would have some git repository that I will pull from CIP and merge into my own tree. I would also be
> pushing that to some local server to share with the other team members in my group.
> 
> Therefore, the 'rebase' thing doesn't make sense to me because if you are pushing a rebased tree, that means you are changing the
> existing parent history and doing a simple 'git pull' doesn't work so well (like what you have with the linux-next tree).

The rebase branch is something complimentary, the maintainer may decide not to prepare it (the same with the patches).
# The rebase branch might useful to see clearly which patches come from the cip kernel and which ones are from PREEMPT RT.

> Do I just fetch and merge from 'linux-4.4.y-cip-rt' periodically as I develop my product, and that will play nicely with the local commits
> that I am also making and pushing locally to my repository?

That should work unless your local commits create some conflict. You can also rebase your local commits at the same time so that you
have them on the top of the git log for convenience.

Thank you,
Daniel 
