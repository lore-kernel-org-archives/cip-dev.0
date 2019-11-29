From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 29 Nov 2019 05:56:38 +0000
Subject: [cip-dev] gitlab mirroring broken after today's gitlab outage?
In-Reply-To: <20191128183819.GA20854@amd>
References: <20191128183819.GA20854@amd>
Message-ID: <OSAPR01MB3234C16FE7977AC34C40A2D692460@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: cip-dev [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf
> Of Pavel Machek
> Sent: Friday, November 29, 2019 3:38 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] gitlab mirroring broken after today's gitlab outage?
> 
> Hi!
> 
> I pushed to kernel.org, but I don't see it on gitlab:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/lo
> g/?h=linux-4.4.y-cip
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/linux-4.4.y
> -cip
> 
> Does something need to be kicked?

When doing a force push on kernel.org, gitlab sync failed.
I think this is the cause.
In this case, manually pushing to gitlab will solve the problem.

I pushed same commit of linux-4.4.-cip branch to gitlab now.
I think this will solve the problem.

Best regards,
  Nobuhiro
