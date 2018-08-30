From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Thu, 30 Aug 2018 10:18:47 +0100
Subject: [cip-dev] Proposal: Gitlab role policy
In-Reply-To: <2718361.41IWGt5yYx@linux-if6s>
References: <2718361.41IWGt5yYx@linux-if6s>
Message-ID: <1653033.Wyh2qVulZg@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

This is a summary of the application of the policy.

On Thursday, 9 August 2018 10:21:50 WEST Agust?n Benito Bethencourt wrote:
> Hi,
> 
> now that we have new kernel maintainers it might be time to pay a little attention  to the user permissions/roles policy at Gitlab.com.
> 
> Some time ago we agreed to divide the different repositories in subgroups in preparation for this time. We can segment the permissions we provide to CIP contributors by subgroup. We have the following subgroups:
> * 3rd party software (mostly related with testing for now (special case)
> * cip-testing
> * cip-kernel
> * cip-core
> 
> For simplicity, I suggest the following:
> * TSC representatives from each company will be owners, as well as the tool admin, at group level.

I have applied Owner rights to the CIP group to the following people:
* Jan K - Siemens
* Yoshi - Toshiba
* Takehisa K - Renesas
* Sz Lin - Moxa
* myself - Codethink
*  - Hitachi
* - Cybertrust
* - Pla'Home

Who should I add from these three Members?

> * We will have no group maintainers by default since we will not have repos at this level but we will enclose them in subgroups. So at this group level we will provide Developer or Reporter roles only to CIP participants.

I have removed the Maintainers.

> * We assign the maintainer role to those who should have it, because they are responsible of a specific area, at subgroup level. 

** cip-testing subgroup:

There are no maintainers at a subgroup level. I have not changed anything here.

** cip-kernel

bwh and iwamatsu have maintainers rights at subgroup level. I have not changed anything here. Please let me know if there are additional people who should be maintainers. Please remember that there are other maintainers but at a repo (project) level.

** 3rd- party

There are no maintainers at a subgroup level. I have not changed anything here.

> * Specific people can hold the maintainer role at repo (project) level based on the subgroup maintainer decision. 

cip-core is a repo and not a subgroup. I have not modified the roles to comply to the policy. I recommend first to move the repo into a subgroup so this effort can apply its own policies, labels, board structure or workflows without affecting others.

> 
> This simple policy can be extended as more people join.
> 
> Best Regards
>  
> 

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
