From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 13 Dec 2019 23:11:55 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip] net: davinci_cpdma: use dma_addr_t
 for DMA address
In-Reply-To: <20191213205656.GA2788@duo.ucw.cz>
References: <20191213205656.GA2788@duo.ucw.cz>
Message-ID: <OSAPR01MB3234810F3C1ACEB6DD43294792540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at ucw.cz]
> Sent: Saturday, December 14, 2019 5:57 AM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Subject: [PATCH 4.4.y-cip] net: davinci_cpdma: use dma_addr_t for DMA
> address
> 
> Hi!
> 
> I have this in 4.4-rt-cip, and it would make my life easier if I applied
> it to 4.4-cip. Would that be ok to do?

I think your suggestion is good because the cip-rt branch is based on the
cip branch.

Or this is not a bug but a warning, but it may be possible to include it with LTS.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/379209573#L8482

Best regards,
  Nobuhiro
