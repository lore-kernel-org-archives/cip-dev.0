From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 22 Nov 2017 17:15:01 +0000
Subject: [cip-dev] [PATCH] spi: pxa2xx: Add support for GPIO descriptor
 chip selects
In-Reply-To: <cc87e6fb-a800-11e6-44c6-150377672ea6@siemens.com>
References: <bbecd99d-a170-8b72-2b38-a9e4fbfd3074@siemens.com>
	<1511369638.18523.121.camel@codethink.co.uk>
	<cc87e6fb-a800-11e6-44c6-150377672ea6@siemens.com>
Message-ID: <1511370901.18523.124.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-11-22 at 18:01 +0100, Jan Kiszka wrote:
> On 2017-11-22 17:53, Ben Hutchings wrote:
> > On Fri, 2017-11-17 at 21:45 +0100, Jan Kiszka wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > commit 99f499cd650405bbe6a9b5386d4b11ee81514fb7 upstream.
> > > 
> > > The driver uses custom chip_info coming from platform data for chip selects
> > > implemented as GPIOs. If the system lacks board files setting up the
> > > platform data, it is not possible to use GPIOs as chip selects.
> > > 
> > > This adds support for GPIO descriptors so that regardless of the underlying
> > > firmware interface (DT, ACPI or platform data) the driver can request GPIOs
> > > used as chip selects and configure them accordingly.
> > > 
> > > The custom chip_info GPIO support is still left there to make sure the
> > > existing systems keep working as expected.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > > 
> > > ...and another one I missed as dependency for our IOT2000.
> > > 
> > > ?drivers/spi/spi-pxa2xx.c | 57 +++++++++++++++++++++++++++++++++++++++++++++---
> > > ?drivers/spi/spi-pxa2xx.h |??3 +++
> > > ?2 files changed, 57 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > > index 3cac73e4c3e4..21339ca204d9 100644
> > > --- a/drivers/spi/spi-pxa2xx.c
> > > +++ b/drivers/spi/spi-pxa2xx.c
> > > @@ -1122,9 +1122,26 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
> > > ?static int setup_cs(struct spi_device *spi, struct chip_data *chip,
> > > > > > ?		????struct pxa2xx_spi_chip *chip_info)
> > > ?{
> > > > > > +	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
> > > > > > ?	int err = 0;
> > > ?
> > > > > > -	if (chip == NULL || chip_info == NULL)
> > > > > > +	if (chip == NULL)
> > > > > > +		return 0;
> > > +
> > > +	if (drv_data->cs_gpiods) {
> > > +		struct gpio_desc *gpiod;
> > > +
> > > +		gpiod = drv_data->cs_gpiods[spi->chip_select];
> > > +		if (gpiod) {
> > > +			chip->gpio_cs = desc_to_gpio(gpiod);
> > > +			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
> > 
> > This assigns a value of 0 or 4 to chip->gpio_cs_inverted, when it
> > surely should be 0 or 1.??With the current gpiolib implementation this
> > appears to work anyway, but I wouldn't want to assume that's true.
> 
> Indeed.
> 
> > 
> > [...]
> > > @@ -1305,7 +1322,8 @@ static void cleanup(struct spi_device *spi)
> > > ????????if (!chip)
> > > ????????????????return;
> > > ?
> > > -???????if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
> > > +???????if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
> > > +???????????gpio_is_valid(chip->gpio_cs))
> > > ????????????????gpio_free(chip->gpio_cs);
> > 
> > [...]
> > 
> > This is really weird; I think the driver should consistently use
> > managed or unmanaged allocation of GPIOs.
> 
> Yes, there is another patch in upstream to improve this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c18d925fca20d33c3d04e5002a883f62d699543e

I'm talking about use of devm_gpio_get() (with automatic free) vs
gpio_request()/gpio_free().

Ben.

> > 
> > But I don't think these are blockers for backporting, so I've applied
> > this anyway.
> > 
> 
> Thanks (also for cross-checking),
> Jan
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
