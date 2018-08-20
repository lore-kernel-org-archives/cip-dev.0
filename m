From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Mon, 20 Aug 2018 18:32:28 +0200
Subject: [cip-dev] Proposal: Gitlab role policy
In-Reply-To: <8acc7cf1-e1b9-524c-3452-3204ac355fdb@toshiba.co.jp>
References: <2718361.41IWGt5yYx@linux-if6s>
	<8acc7cf1-e1b9-524c-3452-3204ac355fdb@toshiba.co.jp>
Message-ID: <4289285.ekA2XtEEmD@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On Monday, 20 August 2018 16:08:36 CEST KOBAYASHI Yoshitake wrote:
> Hi Agustin,
> 
> Thanks for the proposal.
> I think this simple policy works fine in CIP project.

In today's TSC meeting this policy was approved. Thank you all. I will implement it in the coming days. I might ping you individually if you are affected by it.

> 
> Best regards,
> Yoshi
> 
> On 2018/08/09 18:21, Agust?n Benito Bethencourt wrote:
> > Hi,
> > 
> > now that we have new kernel maintainers it might be time to pay a little attention  to the user permissions/roles policy at Gitlab.com.
> > 
> > Some time ago we agreed to divide the different repositories in subgroups in preparation for this time. We can segment the permissions we provide to CIP contributors by subgroup. We have the following subgroups:
> > * 3rd party software (mostly related with testing for now (special case)
> > * cip-testing
> > * cip-kernel
> > * cip-core
> > 
> > For simplicity, I suggest the following:
> > * TSC representatives from each company will be owners, as well as the tool admin, at group level.
> > * We will have no group maintainers by default since we will not have repos at this level but we will enclose them in subgroups. So at this group level we will provide Developer or Reporter roles only to CIP participants.
> > * We assign the maintainer role to those who should have it, because they are responsible of a specific area, at subgroup level. 
> > * Specific people can hold the maintainer role at repo (project) level based on the subgroup maintainer decision. 
> > 
> > This simple policy can be extended as more people join.
> > 
> > Best Regards
> >  
> > 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 


-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
