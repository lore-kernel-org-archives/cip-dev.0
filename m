From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 12 Apr 2019 13:28:21 +0200
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <OSBPR01MB27743C65D403FD9027F2CCF9E1280@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<a3ddd6c7-799b-001f-e134-752766536744@siemens.com>
	<OSBPR01MB2774CEC142FC42D93728BD65E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<4ca0a48f-b728-b7af-eb78-c57f3bf71840@siemens.com>
	<OSBPR01MB27743C65D403FD9027F2CCF9E1280@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <55d67dcb-e16f-8e9f-d053-32bf30537ef6@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 12.04.19 08:05, kazuhiro3.hayashi at toshiba.co.jp wrote:
>>>> Enabling buster should be straightforward, Isar works with it already.
>>>
>>> Great, how can I know that the buster is officially enabled in
>> isar-cip-core?
>>
>> When someone writes the patch(es) :). It's kas magic, I don't think we need
>> more.
> 
> I'm interested in what kind of variables is appropriate to provide the "options" with kas.
> The most simple way I can guess is that:
> 
> * Provide another distro conf (e.g. cip-core_4.19_buster.conf) with the followings
> 	require conf/distro/debian-buster.conf
> 	...
> 	PREFERRED_VERSION_linux-cip ?= "4.19.%"
> 	PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
> 	...
> * Change the default "distro" in kas.yml
> 	-distro: cip-core
> 	+distro: cip-core_4.19_buster
> * The current combination (4.4 + stretch) still available by setting
> 	KAS_DISTRO="cip-core" (or should be renamed to "cip-core_4.4_stretch" ?)
> 
> If no objections or other ideas, I would like to create a simple patch to do that.

I would do the following:

- define distro/cip-core_stretch.conf and distro/cip-core_buster.conf
- maybe redefine distro/cip-core.conf as link to stretch today that is going to move to
  buster once that was released and validated (similar to the default kernel story)
- define PREFERRED_VERSION_linux-cip to 4.19, maybe in a cip-core-common.conf
- allow override via kas fragments:
   - distro: cip-core_buster
   - PREFERRED_VERSION_linux-cip[-rt] = "4.4.%"

> 
> In addition, I'm also interested in the appropriate name for "distro"
> because I'm just considering the branch name for the tiny profile (deby).
> My first idea is the above. After it's decided,,
> we can share the common names for specifying the version combinations between the both profiles.

I think appending the distro version name to the "cip-core" like above is a reasonable approach.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
