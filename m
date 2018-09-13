From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 13 Sep 2018 16:32:36 +0100
Subject: [cip-dev] Can CIP have a group account in kernel.org
In-Reply-To: <13123422.r87sqmyfEU@linux-if6s>
References: <13123422.r87sqmyfEU@linux-if6s>
Message-ID: <1536852756.3024.210.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-08-23 at 09:49 +0100, Agust?n Benito Bethencourt wrote:
> Hi Ben,
> 
> it seems that LTSI[1] and XEN[2] has group accounts at kernel.org
> 
> At today's IRC meeting, some of the attendees were wondering if we
> can also have one so we can transfer the kernel from your personal
> account to the group account, having the new kernel maintainer as
> "account admin". Is that possible? Do we need to ask somebody about
> it?

Sorry for the slow response.

All members of a group need to already have kernel.org accounts.  The
process for getting an account is described at
<https://korg.wiki.kernel.org/userdoc/accounts>.  There is no guarantee
that developers contracted to maintain the CIP kernel would be approved
to get an account.  Getting the necessary PGP key signatures, which
requires in-person meetings, could be difficult for some.

My understanding is that there is no such thing as a group
administrator.  Group membership is managed directly by the kernel.org
administrators at the request of the existing members.  However, in my
experience with the linux-firmware.git repository, Konstantin responds
to these requests quickly.

I understand the desire to have the CIP kernel hosted on
git.kernel.org, to convey that we're part of the kernel development
community.  But I'm not sure that it's actually worth the trouble.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
