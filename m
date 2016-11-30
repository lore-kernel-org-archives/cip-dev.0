From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Nov 2016 12:07:52 +0100
Subject: [cip-dev] Open Source OPC UA
In-Reply-To: <95c6526d-aba5-b321-d086-34e958083e89@linux-kernel.net>
References: <8abd469b-0496-7912-8962-b4c3fd287d15@siemens.com>
	<95c6526d-aba5-b321-d086-34e958083e89@linux-kernel.net>
Message-ID: <e309a68a-d22f-ba8c-e930-d1fc604486eb@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2016-11-30 11:41, Wolfgang Mauerer wrote:
> Am 29/11/2016 um 20:36 schrieb Jan Kiszka:
> 
>> does anyone already have some experience with OSS OPC UA
>> implementations, specifically for resource constrained devices? We
>> stumbled over
>>
>> http://open62541.org
>>
>> which seems like being on the right path. There are more
>>
>> https://github.com/open62541/open62541/wiki/List-of-Open-Source-OPC-UA-Implementations
>>
>> but not all look that attractive for embedded devices, due to language,
>> license or main drivers.
> 
> there's another tiny implementation from some of the Ostwestfalen-Lippe
> (OWL) group of people in Germany, but since it targets devices with
> only 10s of KiB of RAM and ROM, I don't think it's suitable for our
> purposes.

If you have a link (and the project has a proper license), maybe send a
PR to the open62541.org to extend their list.

> 
> As for language and main drivers: Do we have an agreement or an idea
> in the group what suitable languages are, and what characteristics main
> drivers should have? Considering the size of systems we're targeting, I
> personally would not see C (and possibly C++) as the only admissible
> language.

If we only had higher languages, that would be a major limitation. It's
not so much about their size, more about their amount of dependencies
and their suitability for embedded processors (just having "fun" with Go
on Intel Quark...).

But also having bindings for Java, C#, python, JavaScript, Go,
you-name-them, would be valuable. So I would recommend to start with a
common core - thus a native one - and add those bindings to them. Later
on, if there is added value, we could also consider alternative core
implementations.

Regards,
Jan

> 
> Best regards, Wolfgang
>>
>> I think, eventually, CIP should look into the topic free and
>> standard-conforming OPC UA as well because it is gaining a lot of
>> traction as THE protocol for data exchange in automation industry.
>>
>> Regards,
>> Jan
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
>>
