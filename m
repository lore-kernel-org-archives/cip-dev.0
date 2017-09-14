From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 14 Sep 2017 16:55:13 +0100
Subject: [cip-dev] [PATCH 6/8] pwm: pca9685: Allow any of the 16 PWMs to
 be used as a GPIO
In-Reply-To: <5073132a570210d4f5c2790ccae6e18d285dfcca.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
	<5073132a570210d4f5c2790ccae6e18d285dfcca.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <1505404513.1807.52.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-08-30 at 20:52 +0200, Jan Kiszka wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> commit bccec89f0a35f65302734d1cdb01479df0f33ac9 upstream.
[...]
> @@ -87,6 +93,151 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>  	return container_of(chip, struct pca9685, chip);
>  }
>  
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct pca9685 *pca = gpiochip_get_data(gpio);
[...]

gpiochip_get_data() doesn't exist in 4.4.

I've cherry-picked commits b08ea35a3296 "gpio: add a data pointer to
gpio_chip", 0cf3292cde22 "gpio: Add devm_ apis for gpiochip_add_data and
gpiochip_remove", and 3988d663c02f "gpiolib: Fix a WARN_ON that can
never trigger" before this.  But you should have included them in this
patch series.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
