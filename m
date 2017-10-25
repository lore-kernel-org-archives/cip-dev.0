From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 25 Oct 2017 11:43:40 +0200
Subject: [cip-dev] [PATCH 02/10] watchdog: Introduce WDOG_HW_RUNNING flag
In-Reply-To: <20171004144104.14403-3-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
	<20171004144104.14403-3-mosipov@ilbers.de>
Message-ID: <1508924620.22379.79.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-10-04 at 16:40 +0200, Maxim Yu. Osipov wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Backport from kernel.org, upstream commit ee142889e32f
> 
> The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
> the hardware watchdog is running. If the flag is set, the watchdog
> subsystem will ping the watchdog even if the watchdog device is
> closed.
> 
> The watchdog driver stop function is now optional and may be omitted
> if the watchdog can not be stopped. If stopping the watchdog is not
> possible but the driver implements a stop function, it is responsible
> to set the WDOG_HW_RUNNING flag in its stop function.
[...]
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
[...]
> @@ -651,9 +665,24 @@ int watchdog_dev_register(struct watchdog_device
> *wdd)
> ?		if (wdd->id == 0) {
> ?			misc_deregister(&watchdog_miscdev);
> ?			old_wdd = NULL;
> +			if (wdd->ops->unref)
> +				wdd->ops->unref(wdd);
[...]

This doesn't look right.  This is decrementing a reference counter
because the old_wdd reference is going away, but we never increment a
reference counter when old_wdd is set.

The upstream commit doesn't make any change here.  There is a
kref_put() here in the upstream version but that was added as part of
the watchdog_device/watchdog_core_data split.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
