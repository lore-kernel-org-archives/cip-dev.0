From: urs.gleim@siemens.com (Gleim, Urs)
Date: Sat, 24 Sep 2016 15:49:48 +0200
Subject: [cip-dev] Use cases behind CIP story
In-Reply-To: <57DBC9C3.9080604@codethink.co.uk>
References: <57DAA4A6.8090807@codethink.co.uk>
	<CAFo+snWE2xPXgjjbmi2SgLrxMD6O5Oa5CHEyjZ32JN=aw7TYRQ@mail.gmail.com>
	<9c215d3f195ef8f6475a80df95ac9f2e@codethink.co.uk>
	<57DADC13.3080306@codethink.co.uk>
	<515105dd-94a6-d53a-9e13-abed4e7f1eeb@toshiba.co.jp>
	<57DBC9C3.9080604@codethink.co.uk>
Message-ID: <ee0b9025-4727-798f-80e1-0e6652e0a331@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 16.09.2016 12:30, Agustin Benito Bethencourt wrote:
>> It might be better to provide some typical development and maintenance
>> schedule/process
>> to explain why CIP is important for civil infrastructure systems.
>
> Agree.
>
> There is another aspect that many do not consider when approaching the
> maintenance problem which is risk.
>
> We are very use to nowadays to evaluate maintenance costs. But
> maintenance might involve very high risks in certain environments and
> tackle them might require a heavy investment. This might heavily
> affect the maintenance policies. 

let me try to sketch one example for typical rail automation products:
 - development time of a new system: 3-5 years
 - customer specific adaptions: 2-4 years
 - initial safety certifications / authorization: 1 year
 - safety certifications / authorization for follow-up releases: 3-6 months
   (depending on amount of changes)
 - lifetime today typically 25 years, for some systems up to 50 years

Especially the time (and money) required for the certification for new
releases explains why in general there are no frequent updates.
If new releases are necessary, e.g. because of security reasons the
above mentioned efforts can be drastically reduced by only changing
minor parts (efforts of course vary on type of system and safety level).
Less changes mean less effort. Switching a kernel version is not
considered to be a small change. That's why these products typically
stick to a kernel version for long time which has been tested
extensively in the system environment.

We have similar situations in other domains. Healthcare, for example.
The product lifetimes are shorter, typically 10-15 years. Still there
are certifications (like FDA) which have to be done on system level
which lead to the same problems.

In addition to this there is a general trend that safety critical
functions are more and more implemented in software. This means that the
number of products having those certification need will further increase.

I would also like to state one important point: the super-long-term
maintenance is not a crazy idea by some industry people. It is done
already. Only that it is done behind closed doors by privately
maintained patch-sets. And this is what we would like to change.

best regards,
Urs
