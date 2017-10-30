From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 30 Oct 2017 10:22:20 +0100
Subject: [cip-dev] Status of cip-core
In-Reply-To: <002c01d35114$dd9f8090$98de81b0$@toshiba.co.jp>
References: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
	<b10de86c-b50e-33a0-fd74-826d7f4aaa86@siemens.com>
	<002c01d35114$dd9f8090$98de81b0$@toshiba.co.jp>
Message-ID: <3ad5b405-68f6-e964-d0f2-2e54f768ad6f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel

On 10/30/2017 01:20 AM, Daniel Sangorrin wrote:
>> -----Original Message-----
>> From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
>> Sent: Friday, October 27, 2017 9:57 PM
>> To: Daniel Sangorrin; cip-dev at lists.cip-project.org; 'Jan Kiszka'
>> Subject: Re: [cip-dev] Status of cip-core
>>
>> Hi Daniel,
>>
>> On 10/23/2017 11:38 AM, Daniel Sangorrin wrote:
>>> Jan: what is KAS_WORK_DIR in http://kas.readthedocs.io/en/latest/userguide.html#environment-variables?
>>
>> kas is designed so that you need to run it always from the same
>> directory you invoked it first. Basically the root folder for the
>> project. But if you like me, not always running kas from the same folder
>> KAS_WORK_DIR can be used to point to the root folder of the project.
> 
> Thanks, I thought so. My problem was that KAS always puts the results in a folder
> called "build" instead of "build-<target>" for example. 

That sounds like a feature request :) If I am not completely mistaken,
this should be easy to add.

Thanks,
Daniel
