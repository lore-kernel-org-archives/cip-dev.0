From: lava.users.mailinglist@gmail.com (Robert Berger)
Date: Tue, 4 Jul 2017 21:49:15 +0300
Subject: [cip-dev] Fwd: [Lava-users] OE/Yocto testcase
In-Reply-To: <595B87A3.4010207@codethink.co.uk>
References: <798686ec-e4c1-91f2-ed5d-99feee607cd8@gmail.com>
	<595B87A3.4010207@codethink.co.uk>
Message-ID: <7175adaf-2948-72e0-cace-7fe1ae282aed@gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 2017-07-04 15:18, Agustin Benito Bethencourt wrote:
> Dear CIP friends,
> 
> please check below. This is a use case we will meet in a few 
> weeks/months. It is important to see others walking the same route.

My simple tests are running now thanks to the help of the nice people 
from the #linaro-lava chat.

1) Crazy me decided to use upstream u-boot 2017.05 instead of running 
some ancient version from 2014;)

1.1) which happens to have a different AUTOBOOT_PROMPT than the one Lava 
expects "Press SPACE to abort autoboot in %d seconds\n" instead of "Hit 
any key to stop autoboot" so (since) I would like to be able to stay as 
close as possible to upstream LAVA 2017.06 I patched u-boot[1]. Note 
that this could be fixed with LAVA as well - interrupt_prompt: {{ 
interrupt_prompt|default('Hit any key to stop autoboot') }}

1.2) also the SYS_PROMPT of upstream u-boot is different than the one 
expected by LAVA and again I made a u-boot patch[2]. Note that this 
could be fixed with LAVA as well - {% set bootloader_prompt = 
bootloader_prompt|default('U-Boot') %}

2) After some searching it turned out that LAVA set some funny variables 
in u-boot which made my kernel crash. (Crazy me decided to use a 4.9.x 
uImage without baked in address).

Adding this:
{% set base_high_limits = false %}
to my bbb03.jinja2 file fixed it.

... obviously ;)

Regards,

Robert

[1] 
https://github.com/RobertBerger/meta-mainline/blob/pyro-training-v4.9.x/u-boot-wic-bsp/recipes-bsp/u-boot/2017.05/beagle-bone-black/0002-default-AUTOBOOT_PROMPT-for-LAVA.patch
[2] 
https://github.com/RobertBerger/meta-mainline/blob/pyro-training-v4.9.x/u-boot-wic-bsp/recipes-bsp/u-boot/2017.05/beagle-bone-black/0003-SYS_PROMPT-LAVA-compatible.patch
