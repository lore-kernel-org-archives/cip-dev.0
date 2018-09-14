From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 14 Sep 2018 18:44:12 +0200
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <TYAPR01MB216020E4806DE9DD3777D83ED7190@TYAPR01MB2160.jpnprd01.prod.outlook.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
	<TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<fd6af125-0a28-d4a5-85cc-13e94778c7be@siemens.com>
	<TYAPR01MB21605130719706B6F02E8F78D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<2426c261-d153-24e3-4ce3-6cbf8f52d7c7@siemens.com>
	<TYAPR01MB216052195F4D0BADFC698B29D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<5f005779-cbd2-430d-73a7-394696ff108a@siemens.com>
	<TYAPR01MB2160616915C67118BF018AB0D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<TYAPR01MB216020E4806DE9DD3777D83ED7190@TYAPR01MB2160.jpnprd01.prod.outlook.com>
Message-ID: <b8b335cd-ed91-a520-0f3b-42cae5064623@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 14.09.18 12:45, ???? / KOGUCHI?TAKUO wrote:
> Jan,
> 
> Have you been making progress with this?
> I have confirmed that;
> (1) linux-4.13 and linux-4.14 works on my board without any modification to the denali driver.
> (2) linux-4.15 to linux-4.19-rc3 need a single extra line. I do not know a better fix.
> 
> If you have an update, I would like to try it on my board.

Marek may be able to comment on the details of your change better than I.

We are using the queue now with some extensions. I need to dig them out and will 
try to refresh the queue I published.

Thanks,
Jan

> 
> Best regard,
> 
> Takuo
> 
> ---------------------------------
> From: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
> Date: Fri, 14 Sep 2018 18:38:43 +0900
> Subject: [PATCH] MTD NAND Denali fix for Cyclonev
> 
> Reading back DMA_ENABLE register just after enabling it, this is removed
> by commit: [586a2c52909df453ed1b6239283744b0851ccf81]
> mtd: nand: denali: squash denali_enable_dma() helper into caller
> 
> Without this denali_wait_for_irq timeout for INTR__DMA_CMD_COMP.
> 
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
> ---
>   drivers/mtd/nand/raw/denali.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 67b2065..4ba997b 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -596,6 +596,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
>   	}
>   
>   	iowrite32(DMA_ENABLE__FLAG, denali->reg + DMA_ENABLE);
> +	ioread32(denali->reg + DMA_ENABLE);
>   
>   	denali_reset_irq(denali);
>   	denali->setup_dma(denali, dma_addr, page, write);
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
