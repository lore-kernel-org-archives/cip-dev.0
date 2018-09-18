From: kazuhiro3.hayashi@toshiba.co.jp (HAYASHI Kazuhiro)
Date: Tue, 18 Sep 2018 13:25:14 +0900
Subject: [cip-dev] [PATCH] spi: pxa2xx: Fix build error because of
 missing header
In-Reply-To: <1537243810-2074-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1537243810-2074-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Message-ID: <201809180425.w8I4PFGc005979@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 2018/09/18 13:10, Kazuhiro Hayashi wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> commit 089bd46d8bc1fe5a28351e82e4adcaa5a40121b5 upstream.
> 
> Kbuild test robot reports:
> 
>    drivers/spi/spi-pxa2xx.c: In function ?setup_cs?:
>    drivers/spi/spi-pxa2xx.c:1190:20: error: implicit declaration of function ?desc_to_gpio?
>    ...
I got the above error when I enabled pxa2xx by
CONFIG_SPI_PXA2XX_DMA=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
and confirmed that the patch fixes the issue.

Kernel version: 4.4.138-cip25-rt19
Architecture: x86_64
gcc: 4.9.2 (Debian 8)

This issue seems to be caused by 3d3bc507 in CIP (99f499cd in upstream) [1],
and the patch is already merged in the upstream.
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git/commit/?id=3d3bc50700ba7e7c370229f20f0b3ddafc1562cd
Please consider to apply the patch to 4.4-cip as well.

[1] https://lists.01.org/pipermail/kbuild-all/2016-September/025744.html

Regards,
Kazu

> 
> Reason for this is the fact that those functions are declared in
> linux/gpio/consumer.h which is not included in the driver. Fix this by
> including it.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> ---
>   drivers/spi/spi-pxa2xx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 5e2ed7d..dd7b5b4 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -28,6 +28,7 @@
>   #include <linux/spi/spi.h>
>   #include <linux/delay.h>
>   #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/clk.h>
>   #include <linux/pm_runtime.h>
> 


-- 
  Kazuhiro Hayashi
  Corporate Software Engineering & Technology Center
  Toshiba Corporation
  Tel: +8144-549-2476
  E-mail: kazuhiro3.hayashi at toshiba.co.jp
