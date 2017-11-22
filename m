From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 22 Nov 2017 16:54:40 +0000
Subject: [cip-dev] [PATCH] spi: pxa2xx-pci: fix ACPI-based enumeration
 of SPI devices
In-Reply-To: <f901fec0-86ea-ab4c-5130-1b10b4b0c065@siemens.com>
References: <f901fec0-86ea-ab4c-5130-1b10b4b0c065@siemens.com>
Message-ID: <1511369680.18523.122.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2017-11-16 at 13:06 +0100, Jan Kiszka wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> commit b70cd2de0ea85f5ab51a1d01893cba6415011b9d upstream.
> 
> Slave devices are not enumerated by ACPI data because the ACPI handle for the
> core driver is NULL if it was enumerated by PCI.
> 
> Propagate firmware node handle of the PCI device to the platform device.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Required for our IOT2000 devices to work properly.
[...]

Applied, thanks.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
