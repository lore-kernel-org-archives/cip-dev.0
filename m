From: wagi@monom.org (Daniel Wagner)
Date: Fri, 27 Apr 2018 14:10:23 +0200
Subject: [cip-dev] Linux 4.4.126-cip22
In-Reply-To: <1fe18b95-eb3d-09a8-7e78-e686a8fc41ff@monom.org>
References: <1523476441.2951.8.camel@codethink.co.uk>
	<1523477437.2951.10.camel@codethink.co.uk>
	<90f2920d-abbb-affc-35f7-54161a13173c@monom.org>
	<1fe18b95-eb3d-09a8-7e78-e686a8fc41ff@monom.org>
Message-ID: <b0cba6f1-3614-786c-b665-5189b168afe0@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> I guess those two symbols are just missing the export. Patch in the works.

Uwe was faster. I think you should add these two patches to your tree:

82a3f87f6e80 ("serial: mctrl_gpio: Add missing module license")
f71a2e0a282 ("serial: mctrl_gpio: export mctrl_gpio_disable_ms and 
mctrl_gpio_init")

Thanks,
Daniel
