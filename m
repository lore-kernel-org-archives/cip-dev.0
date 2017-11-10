From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Fri, 10 Nov 2017 13:09:54 +0100
Subject: [cip-dev] [PATCH 00/10] Backport of watchdog core triggered
	keepalive infrastructure v2
Message-ID: <20171110121004.17775-1-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

This is updated series after Ben's review.

>>>>>>>>>>
* On 10/25/17 12:43, Ben Hutchings wrote:
> On Wed, 2017-10-04 at 16:40 +0200, Maxim Yu. Osipov wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> Backport from kernel.org, upstream commit ee142889e32f
>>
>> The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
>> the hardware watchdog is running. If the flag is set, the watchdog
>> subsystem will ping the watchdog even if the watchdog device is
>> closed.
>>
>> The watchdog driver stop function is now optional and may be omitted
>> if the watchdog can not be stopped. If stopping the watchdog is not
>> possible but the driver implements a stop function, it is responsible
>> to set the WDOG_HW_RUNNING flag in its stop function.
> [...]
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
> [...]
>> @@ -651,9 +665,24 @@ int watchdog_dev_register(struct watchdog_device
>> *wdd)
>>   		if (wdd->id == 0) {
>>   			misc_deregister(&watchdog_miscdev);
>>   			old_wdd = NULL;
>> +			if (wdd->ops->unref)
>> +				wdd->ops->unref(wdd);
> [...]
> 
> This doesn't look right.  This is decrementing a reference counter
> because the old_wdd reference is going away, but we never increment a
> reference counter when old_wdd is set.
> 
> The upstream commit doesn't make any change here.  There is a
> kref_put() here in the upstream version but that was added as part of
> the watchdog_device/watchdog_core_data split.
> 
> Ben.
> 

* On 10/25/17 12:46, Ben Hutchings wrote:
> Please use one of these formats for upstream references in the commit
> messages:
> 
>      commit 0123456789012345678901234567890123456789 upstream.
> 
>      [ Upstream commit 0123456789012345678901234567890123456789 ]
> 
> Ben.
> 

<<<<<<<<<<<<<


This series contains 

* backport of patches of watchdog core infrastructure 
supporting handling watchdog keepalive. 

* imx21_wdt converted to use infrastructure triggered keepalives.

* backported support of WATCHDOG_HANDLE_BOOT_ENABLED option 
 
On some systems it's desirable to have watchdog reboot the system
when it does not come up fast enough. This adds a kernel parameter
to disable the auto-update of watchdog before userspace takes over
and a kernel option to set the default.

One of the important use cases is safe system update.
In that case, the bootloader enables the watchdog, and Linux should only
take it over@the point the whole Linux system is sure to be able to
have a fully working system again, including userspace services that
could take the next update. If we start the trigger the watchdog too
early, like it was so far, we risk to enter a system state where the
kernel works but not all other services we need.

i.MX6 based board was used as a test platform. 

We suppose that watchdog is enabled in bootloader and set to 120 seconds 
(maximum timeout supported by i.MX watchdog timer)

After applying these patches, built-in i.MX watchdog (imx21_wdt) into 
kernel and perform the following test cases:

1) option WATCHDOG_HANDLE_BOOT_ENABLED is turned off in kernel configuration
w/o userspace application triggering the watchdog. 

Make sure that no userspace application is triggering watchdog.

After around 120 seconds (timeout set in bootloader) board will reboot.

2) option WATCHDOG_HANDLE_BOOT_ENABLED is turned off in kernel configuration
but userspace application is triggering watchdog more frequently that watchdog's
timeout (by default set to 60 seconds for imx21_wdt).

Watchdog will not reboot the board until the application re-arms 
the watchdog.

3) option WATCHDOG_HANDLE_BOOT_ENABLED is turned on in kernel configuration
w/o userspace application triggering the watchdog. 

Make sure that no userspace application is triggering watchdog.
Board will not reboot (watchdog keepalive is supported by watchdog core 
infrastructure, not by driver itself)

Kind regards,
Maxim.

Guenter Roeck (6):
  watchdog: Introduce hardware maximum heartbeat in watchdog core
  watchdog: Introduce WDOG_HW_RUNNING flag
  watchdog: Make stop function optional
  watchdog: imx2: Convert to use infrastructure triggered keepalives
  watchdog: core: Fix circular locking dependency
  watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function

Pratyush Anand (1):
  watchdog: skip min and max timeout validity check when
    max_hw_heartbeat_ms is defined

Rasmus Villemoes (1):
  watchdog: change watchdog_need_worker logic

Sebastian Reichel (1):
  watchdog: core: add option to avoid early handling of watchdog

Wei Yongjun (1):
  watchdog: core: Fix error handling of watchdog_dev_init()

 Documentation/watchdog/watchdog-kernel-api.txt |  51 +++++--
 drivers/watchdog/Kconfig                       |  11 ++
 drivers/watchdog/imx2_wdt.c                    |  74 ++--------
 drivers/watchdog/watchdog_core.c               |   4 +-
 drivers/watchdog/watchdog_dev.c                | 196 +++++++++++++++++++++++--
 include/linux/watchdog.h                       |  40 ++++-
 6 files changed, 277 insertions(+), 99 deletions(-)

-- 
2.11.0
