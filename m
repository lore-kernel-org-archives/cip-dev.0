From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 18 Sep 2018 07:18:57 +0200
Subject: [cip-dev] [PATCH] spi: pxa2xx: Fix build error because of
 missing header
In-Reply-To: <201809180425.w8I4PFGc005979@toshiba.co.jp>
References: <1537243810-2074-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
	<201809180425.w8I4PFGc005979@toshiba.co.jp>
Message-ID: <a6f0bf07-7d99-9672-68d5-73f95f586723@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 18.09.18 06:25, HAYASHI Kazuhiro wrote:
> Hi,
> 
> On 2018/09/18 13:10, Kazuhiro Hayashi wrote:
>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> commit 089bd46d8bc1fe5a28351e82e4adcaa5a40121b5 upstream.
>>
>> Kbuild test robot reports:
>>
>> ?? drivers/spi/spi-pxa2xx.c: In function ?setup_cs?:
>> ?? drivers/spi/spi-pxa2xx.c:1190:20: error: implicit declaration of function 
>> ?desc_to_gpio?
>> ?? ...
> I got the above error when I enabled pxa2xx by
> CONFIG_SPI_PXA2XX_DMA=y
> CONFIG_SPI_PXA2XX=y
> CONFIG_SPI_PXA2XX_PCI=y
> and confirmed that the patch fixes the issue.
> 
> Kernel version: 4.4.138-cip25-rt19
> Architecture: x86_64
> gcc: 4.9.2 (Debian 8)
> 
> This issue seems to be caused by 3d3bc507 in CIP (99f499cd in upstream) [1],
> and the patch is already merged in the upstream.
> https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git/commit/?id=3d3bc50700ba7e7c370229f20f0b3ddafc1562cd 
> 
> Please consider to apply the patch to 4.4-cip as well.
> 
> [1] https://lists.01.org/pipermail/kbuild-all/2016-September/025744.html

We are building that config, and I just checked my last log for 138-cip25 - 
nothing. Maybe it was surfaced by some change after that release.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
