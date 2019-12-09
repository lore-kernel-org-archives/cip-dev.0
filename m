From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 9 Dec 2019 21:25:56 +0000
Subject: [cip-dev] Linux 4.4.207-rc1 8dbad6fe errors
In-Reply-To: <20191209170047.GC1290729@kroah.com>
References: <TYAPR01MB22854300E93B9F6D02232982B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191209170047.GC1290729@kroah.com>
Message-ID: <TYAPR01MB2285A8A7863EA1C8DB01E256B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> Behalf Of Greg Kroah-Hartman
> Sent: 09 December 2019 17:01
> 
> On Mon, Dec 09, 2019 at 04:33:17PM +0000, Chris Paterson wrote:
> > Hello Greg, all,
> >
> > I've seen an error with 4.4.207-rc1 (8dbad6fe).
> >
> > 1)
> > Config: arm multi_v7_defconfig
> > Link: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/373483706#L3649
> > Probable culprit: bc15f46a10dc ("serial: pl011: Fix DMA ->flush_buffer()")
> > Issue log:
> > 3649 drivers/tty/serial/amba-pl011.c: In function 'pl011_dma_flush_buffer':
> > 3650 drivers/tty/serial/amba-pl011.c:697:2: error: implicit declaration of
> function 'dmaengine_terminate_async'; did you mean
> 'dmaengine_terminate_all'? [-Werror=implicit-function-declaration]
> > 3651   dmaengine_terminate_async(uap->dmatx.chan);
> > 3652   ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I'll go drop the offending patch now, thanks for letting me know.

Thanks Greg, building okay for me now.

Regards, Chris

> 
> greg k-h
