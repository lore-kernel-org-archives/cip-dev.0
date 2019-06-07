From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 07 Jun 2019 15:55:58 +0100
Subject: [cip-dev] [isar-cip-core] iwg20m: temporary patch for review v2
In-Reply-To: <20190605021645.4464-2-daniel.sangorrin@toshiba.co.jp>
References: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
	<20190605021645.4464-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1559919358.21054.5.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-06-05 at 11:16 +0900, Daniel Sangorrin wrote:
> I added a revipe for building iwg20m's u-boot.
> This u-boot is very old (2013) and had some compile problems.
> 
> - u-boot fatal error: linux/compiler-gcc6.h: No such file or directory
> - arm-linux-gnueabihf-ld.bfd: unrecognized option '-Wl,-z,relro'
>
> I solved the first one but not the second one.
[...]

"-Wl,-z,relro" is a gcc option which should result in passing
"-z relro" to the linker.  Perhaps a Makefile is invoking $(LD) with
$(LDFLAGS), where it should be invoking $(CC) instead?

In any case, this is a hardening option for dynamically linked binaries
and I don't think it makes any difference to the kernel or u-boot.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
