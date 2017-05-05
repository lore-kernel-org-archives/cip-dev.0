From: don.brown@codethink.com (Don Brown)
Date: Fri, 05 May 2017 16:57:54 -0400
Subject: [cip-dev] Creating a Linux kernel from the stock linux-cip repo
Message-ID: <e9a6f6eff0f21155d7b6b77282912377@codethink.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

As I was working with the Beaglebone Black trying to get the health 
check to pass, it occurred to me that I don't know how to create a 
kernel specifically for the BBB using just the stock CIP Kernel from 
https://gitlab.com/cip-project/linux-cip

The linux-cip kernel doesn't have a defconfig for the Beaglebone Black, 
or for the AM335x CPU as far as I can tell.

The Linaro BBB Health Check pulls the am335x-boneblack.dtb from their 
repository, but it isn't clear what we need to add to the linux-cip to 
have KernelCI build the kernel from scratch. Can you please take a look 
and let us know?

The official repo is at:
https://github.com/beagleboard/linux

It has a bb.org_defconfig here: 
https://github.com/beagleboard/linux/blob/4.4/arch/arm/configs/bb.org_defconfig
Is that all we need?


Thank you!



-- 
Don Brown
Codethink, Ltd.
Software Engineering Consultant
Indianapolis, IN USA
Email: don.brown at codethink.co.uk
Mobile: +1 317-560-0513
