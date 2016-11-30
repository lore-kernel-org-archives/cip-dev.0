From: wm@linux-kernel.net (Wolfgang Mauerer)
Date: Wed, 30 Nov 2016 11:41:08 +0100
Subject: [cip-dev] Open Source OPC UA
In-Reply-To: <8abd469b-0496-7912-8962-b4c3fd287d15@siemens.com>
References: <8abd469b-0496-7912-8962-b4c3fd287d15@siemens.com>
Message-ID: <95c6526d-aba5-b321-d086-34e958083e89@linux-kernel.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Am 29/11/2016 um 20:36 schrieb Jan Kiszka:

> does anyone already have some experience with OSS OPC UA
> implementations, specifically for resource constrained devices? We
> stumbled over
> 
> http://open62541.org
> 
> which seems like being on the right path. There are more
> 
> https://github.com/open62541/open62541/wiki/List-of-Open-Source-OPC-UA-Implementations
> 
> but not all look that attractive for embedded devices, due to language,
> license or main drivers.

there's another tiny implementation from some of the Ostwestfalen-Lippe
(OWL) group of people in Germany, but since it targets devices with
only 10s of KiB of RAM and ROM, I don't think it's suitable for our
purposes.

As for language and main drivers: Do we have an agreement or an idea
in the group what suitable languages are, and what characteristics main
drivers should have? Considering the size of systems we're targeting, I
personally would not see C (and possibly C++) as the only admissible
language.

Best regards, Wolfgang
> 
> I think, eventually, CIP should look into the topic free and
> standard-conforming OPC UA as well because it is gaining a lot of
> traction as THE protocol for data exchange in automation industry.
> 
> Regards,
> Jan
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 
