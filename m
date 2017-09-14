From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 14 Sep 2017 17:55:32 +0100
Subject: [cip-dev] [PATCH 00/25] EXAR UART support for IOT2040 device
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <1505408132.1860.3.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-08-30 at 21:05 +0200, Jan Kiszka wrote:
> Second chunk: This imports a number of preparatory patches in order to
> fully exploit the PCI-attached dual-port EXAR with RS232/422/485 on the
> IOT2040.
> 
> To avoid having to backport also API-changing patches for platform
> devices, I've slightly modified two patches to use a communication
> pattern that does not require these changes.
[...]

Applied this series, except the gpiolib additions which were needed
earlier.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
