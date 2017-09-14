From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 14 Sep 2017 16:55:44 +0100
Subject: [cip-dev] [PATCH 0/8] Basic support for IOT2000 devices
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <1505404544.1807.53.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-08-30 at 20:52 +0200, Jan Kiszka wrote:
> This is the first of 3 chunks to enable the CIP kernel for the IOT2000
> devices. It has the side effect of improving also the support of the
> by now discontinued Galileo Gen 2 board.
> 
> Features added:
>  - Ethernet MACs on IOT2000
>  - TI ADC108S102 on IOT2000 and Galileo
>  - I2C frequency tuning on IOT2000
>  - GPIO support for pca9685 PWMs on IOT2000 and Galileo
>  - interrupt support for PCAL9535 on IOT2000 and Galileo
[...]

Applied this series, along with the gpiolib additions already noted.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
