From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 8 Oct 2018 14:33:32 +0200
Subject: [cip-dev] Kernel configurations in the CIP project
In-Reply-To: <20181005041038.GB30868@osadl.at>
References: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de>
	<005801d45aa8$51f7b1e0$f5e715a0$@toshiba.co.jp>
	<1538661106.3024.266.camel@codethink.co.uk>
	<20181005041038.GB30868@osadl.at>
Message-ID: <ff709c8c-27d9-0a50-780b-cfb5bea7c062@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05.10.18 06:10, Nicholas Mc Guire wrote:
> On Thu, Oct 04, 2018 at 02:51:46PM +0100, Ben Hutchings wrote:
>> On Wed, 2018-10-03 at 08:33 +0900, Daniel Sangorrin wrote:
>>> Hello Lukas,
>>>
>>>> -----Original Message-----
>>>> From: cip-dev-bounces at lists.cip-project.org
>>>> Hi Robert,
>>>>
>>>> If I recall our conversation and follow the discussion on cip-dev correctly, you are still
>>>> maintaining the test builds and infrastructure from the CIP project, right?
>>>>
>>>> Could you provide to Markus Kreidl, Nicholas McGuire (see CC) and me the kernel
>>>> configurations you use in the test builds for the different CIP members?
>>>
>>> Not sure about the configs that Robert uses for testing, but the configurations from CIP members can be found here.
>>> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
>> [...]
>>
>> I think these are the configurations that Lukas needs - they are the
>> configurations that should be used for determining whether commits are
>> relevant to CIP.
>>
> ok - we started playing with them the siemens iot config seems very large to me is that
> a designed config or did that "happen" ?

The IOT2000 is an open platform, and that naturally brings in the need to have 
more features preconfigured than one would selected in a dedicated devices, e.g. 
drivers for pluggable devices.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
