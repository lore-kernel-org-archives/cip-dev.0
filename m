From: yoshitake.kobayashi@toshiba.co.jp (KOBAYASHI Yoshitake)
Date: Mon, 20 Aug 2018 23:08:36 +0900
Subject: [cip-dev] Proposal: Gitlab role policy
In-Reply-To: <2718361.41IWGt5yYx@linux-if6s>
References: <2718361.41IWGt5yYx@linux-if6s>
Message-ID: <8acc7cf1-e1b9-524c-3452-3204ac355fdb@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,

Thanks for the proposal.
I think this simple policy works fine in CIP project.

Best regards,
Yoshi

On 2018/08/09 18:21, Agust?n Benito Bethencourt wrote:
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
> * We will have no group maintainers by default since we will not have repos at this level but we will enclose them in subgroups. So at this group level we will provide Developer or Reporter roles only to CIP participants.
> * We assign the maintainer role to those who should have it, because they are responsible of a specific area, at subgroup level. 
> * Specific people can hold the maintainer role at repo (project) level based on the subgroup maintainer decision. 
> 
> This simple policy can be extended as more people join.
> 
> Best Regards
>  
> 
