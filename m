Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD15C48BF8
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 12:14:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.47])
 by mx.groups.io with SMTP id smtpd.web11.11374.1708604059008777422
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Feb 2024 04:14:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PC2NjPTt;
 spf=pass (domain: siemens.com, ip: 40.107.21.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8o1WKX+wNOracHzuzON39nNIb3VC0mFsMUxA5npuofsmsfcfpbdEuUX+JNAO6q+EZ9B6PGH/ZaU3BbLF1IxzPwjCII17mjGQUcNLq3mPWbu5DDNZsfxTIhkqBWDQuZCBUhWYi1pZSAig1ZaVBP9LQQMyFvsf9iO5vevbQRl5n1m7dagXwBvgkBtg6bgt5crApGgnVA7DLESe7MAMlJRUn13Ymicf9HXwZ8TBIAl8BwinDqqbfkZlQYHClX3i8gLwYix9C+IWNZTySfYG4/qRh4qeLOj4wJPzUp3l1NkzusJGu7BzF9PK0vsWkgPrmWKJZpcLsE5ykRCo1W0ETVNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVBWD8OHNqS0dciSzsfCcGEl2JYINonaixvpIRbcpRI=;
 b=Mhbr59JnWmXTK0sOKncydBYWgFEQetgFN0Hl8Ashqd+87X9akOqUtU0asgy489wMUWBeeVfEFPQJaq0ASQrXGhPM8uX1sq8dpNJ1UKIzshhOvCX1H+O7dV68aA/WCHfIYvqGykcGohvuw/9bs7Alvdqs6YHfldVoqS7cb/z+TOR1X9PWgQ6Ur+iGIh1B+pdKTEs6yFADARGzM9sl5+99kvj/B8nWspiRJf/vw1jXDL9cuTbqTDQ176zk9b3cbFikNdpcJO0+GD4PJM8WObf27rDF3VAhwZ7hQSR4Nhm1UEhapjt9I6dHb7LRK54xyKSUVWGy8HE2DXIjeuaGVdnDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVBWD8OHNqS0dciSzsfCcGEl2JYINonaixvpIRbcpRI=;
 b=PC2NjPTtsniwpQG11eQEk9Na+26yjW3+GHYkrYEHFSn7D4so0DLWhxbO/9I2vHljJJ1AYk3rM5Zo3CpXnWn5XYx1bJq58oP1PXDQp7J6zLk0h8C0b1I0cUju71KlUk+s5aqS77T6bqcDaP65DkyapmtwVygOn5oxEkGacYFTtgfWAbnP4Oqv9zdVDnbRTZWDYtaN2VNqsaCnAvzlv8z2G6+DRYt/XlgQTQKZr9zZXTQ3cbQW1hgWoqOxLu1Na6jNu6UixdhxIqj+aCzMx3U4ayRtFyvUXDlfF+mFoYlBplK+aTcY3IGPBXOUiIgwAu9bHsOtIsvG5ym68mA0fs1sCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 12:14:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 12:14:15 +0000
Message-ID: <6dc0de8d-0d14-4f4d-8de7-c83e1a8502c7@siemens.com>
Date: Thu, 22 Feb 2024 13:14:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5] swupdate.bbclass: add scripts
 section to the swu file
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240216172348.313789-1-Quirin.Gylstorff@siemens.com>
 <c289979e-c222-4464-8ee8-b7b1f2e71aa5@siemens.com>
 <9e23bdf2-a914-4498-aac9-3324baf000ef@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9e23bdf2-a914-4498-aac9-3324baf000ef@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3482:EE_
X-MS-Office365-Filtering-Correlation-Id: eafa6eac-fa8c-4c75-1b0c-08dc339fc96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	thsBTgPNbCMABRUkwGRe8X5BLI+vRJp8fjc24cBC3wg5lziX3zROUZrRKqp9B4YmJwoblcruT6ELySbcFhbYObZp6wYTCY5YdUI8ntMsqDHi5TpVGAUqgpllZW+ltSbsNxiC8i2a4s1RxmdkSnlQLxzE7zvldQXKWe/12yQA4W7s3MZmsX1y1tBpjxC2/wOSmQ2vqi3ze0n8WKgAKeN6q7wfU4xAbLJdgjGSZIet555KnSYt7XJZrzbYKfQzb4+FdVvR9tvbZR44CDHCEOKMgjMvZ+pbv7VAjQR6GIl/vUgETLTgx5Hf8uplcF8NaTunaQFj37DTwWy3tErAK2Nf3ZWHD8qd2MIVoocDE9EKnkRRHp2MVm7fXb/ex75S0DEJpYpqBQZb2gLYY2Da4nyHunEaY/ShBriOjx9hp355103bCmRUIEoH5NiCg3SyqwzGyyhk8TZ90vQZsIXyI00jWHjsu9pTNDE+cuHK1lRdh5Gc1sV4nYbzpVkpriJ/483fZvN4A38OzCkh7pkMxcssnJKkfWFLoyi8fLhdWR8Wr+4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rAXOfQ5USkQOwjQWnHnnnOVQiGZvb78/Lg44tNAMW/BcnOR1BvkYJNiktJpJ?=
 =?us-ascii?Q?E97ajY3U91zhnGbCV4+vcOs5sAhHA9Ovb8iN8CIIePdnb2rl6my3ml0qjwWp?=
 =?us-ascii?Q?ePHcpt+CUmn6+u1PkijjHVRmesu22zpvTZ3zqkMnp+8wxly9CdNDTLsEJ25q?=
 =?us-ascii?Q?hVpbJYQxRJ0MSuztO+Oz7d8AoLas3XMdnzWI0ST6RItDkNzeSRuY5fVPs3Rp?=
 =?us-ascii?Q?Ex5QRiiVoZNgo3UDDuvhFth6yfKq0N7nvXydwXHONlE99Y8yDKoAh91mb9AX?=
 =?us-ascii?Q?oygmF7sm8HE2hdu3O9g1ODrfk2s4o4tGbTo+rslUhDRYKLiV3nuAPhUQyKNe?=
 =?us-ascii?Q?bwjhiAE8Sl8jxC1GXpkQGRLnNVq7AxE4ISCyWpT+eJ/lY6HYaYuERvSmTAMt?=
 =?us-ascii?Q?SNIA9VmH9+Sls+HJCNEh5jxUh1TkgPPa6Ll/v7soV5yt4JC6RmyT+SeIr0EB?=
 =?us-ascii?Q?5K6HL4p1807YEJdFkAu8hg4Bv2OAnu5itSgOUsiy57HlPIqSHurm0f0God+7?=
 =?us-ascii?Q?8oXrMq6Z8G4ClZgRTT8uOYZqT45kyR3gJ+MuJCQcgR9YnMT5l0SO7U/XePdr?=
 =?us-ascii?Q?skjVGQJZv7L/huCJi70OuD0MwZq24oiF/qFiRfynqa8UINTwa8WLOOTKJkoA?=
 =?us-ascii?Q?M1sEiYtVPMUOHlS1mWfF/yC6DAa99VZ6q84z+8EEahyKdGNR6patjCJPRkne?=
 =?us-ascii?Q?BkHcyBs5U2L8fIt5iqZdudBrwwtko7BKS7pi9yASFXxXem5GK9VenCx5ij2O?=
 =?us-ascii?Q?7m5sdqPsUxrup3TbE+TaFnpLjEpdRsZBtZyvXwkkoB7byCYfj5f36NRXMDV/?=
 =?us-ascii?Q?hEK0C4UtNeQQuQ2Pa26FOTqKZh/oyThNwr+CFAYsLbX2MDCx7U413fuFUKbU?=
 =?us-ascii?Q?AYS/LicU9U+d9E3/ggcBXhwJQXibO5gpnjstT3y9NoNar1oV5m6f/CWCr3EY?=
 =?us-ascii?Q?9r7Mz1Ya7/Hls7r1tMamBZGBoVGHhOp0/X2+hnud4suvUlHr0RIpP6hDAcH4?=
 =?us-ascii?Q?cRhoW4wzKDBUogOuoCoTD9mhPucjNnXExQwgYaZ4lrTxXfbfms/p9ww+uGpl?=
 =?us-ascii?Q?N5UpWnnllfbfy8eZTei91FCIsxz4gnBW984DfdvivUaQeF4AJ5AOQP127yfW?=
 =?us-ascii?Q?HOIJqHcuHeCxzNGOUohu7A/y9Yp9UDAF/tHkyaI4tBmSmut+nEP5UCl98lIQ?=
 =?us-ascii?Q?kDWFUX3Ssp1G9V8xI3ptEW2KLOtqj9m0UVPQF4GIYeisd1+uVfLxJ5waVKHH?=
 =?us-ascii?Q?8gjKOO/zqVdoTTXTIAtCaVYAcBc53EE6Zh12DvvnBSmuhKgjcFJy0v83Wv+/?=
 =?us-ascii?Q?DchLv+5YinwMfCS9apyR2/4nrRgsHVLURPhN9s4gMUpUZDscRazUyoK1Wlqa?=
 =?us-ascii?Q?M3SL3peLsb7gfaeKpMCXyMmU+mE/yG3fsJlQ9RV7NmZHZ40VZsUylRRh/c9h?=
 =?us-ascii?Q?8fc7J0fTaMh660QpN4IvbcJZ6vZJxwoe/U10uOb36lpq8JYq2wK/K6xgkrAi?=
 =?us-ascii?Q?str7r35Jq3CRbM+NkJrKpmSN3vSP6PKo15Y+8uZYelvIuRyqrrWuaoHlXUtQ?=
 =?us-ascii?Q?mfCBcQJZFNO5wW1lo3u7fzeGEQckoUw7JVCJkw9lt1ad2rAXalEdVwQY9cmt?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa6eac-fa8c-4c75-1b0c-08dc339fc96a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:14:15.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTg4BlWzErhxfSTcNu1QAiR3flEC8TeoxMVsvJNU5pt4xYRQbfxAbNx6p+yPg7hkeriwyb7Md2G4wYXk2usUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3482
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 12:14:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15060

On 22.02.24 12:47, Gylstorff Quirin wrote:
>=20
>=20
> On 2/19/24 13:01, Jan Kiszka wrote:
>> On 16.02.24 18:23, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows the user to add scripts[1] to the swu file by
>>> setting the variable `SWU_SCRIPTS`. Scripts can be used to
>>> prepare the system for an update.
>>>
>>> ```
>>> SWU_SCRIPTS =3D "postinstall"
>>> SWU_SCRIPT_postinstall[file] =3D "postinstall.sh"
>>> SWU_SCRIPT_postinstall[type] =3D "postinstall"
>>> ```
>>> An optional data element is possible with
>>>
>>> ```
>>> SWU_SCRIPT_postinstall[data]=3D "some_data"
>>> ```
>>>
>>> This will add=C2=A0 `file://<script_file_name>` to the variable `SRC_UR=
I` and
>>> `<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description
>>> will contain
>>> the following section:
>>> ```
>>> =C2=A0=C2=A0=C2=A0=C2=A0 scripts: (
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =
=3D "<script_file_name>";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "=
<script_type>";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D "=
<script_data>";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D=
 "<automatically added sha256 of script_file_name>";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },):
>>> ```
>>>
>>> [1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 46 +++++++++++
>>> =C2=A0 doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 86 +++++++++++++++++++++
>>> =C2=A0 recipes-core/images/swu/sw-description.tmpl |=C2=A0 1 +
>>> =C2=A0 3 files changed, 133 insertions(+)
>>>
>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>> index 403bdef..75a421d 100644
>>> --- a/classes/swupdate.bbclass
>>> +++ b/classes/swupdate.bbclass
>>> @@ -57,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWU_NAME \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>> +=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>> =C2=A0 =C2=A0 # TARGET_IMAGE_UUID needs to be generated before completi=
ng the
>>> template
>>> @@ -93,6 +94,51 @@ python add_swu_compression(){
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.setVar('SWU_CO=
MPRESSION_NODE', '')
>>> =C2=A0 }
>>> =C2=A0 +
>>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_scripts"
>>> +python add_scripts(){
>>> +=C2=A0=C2=A0=C2=A0 swu_scripts =3D d.getVar('SWU_SCRIPTS')
>>> +=C2=A0=C2=A0=C2=A0 if not swu_scripts:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>>> +=C2=A0=C2=A0=C2=A0 swu_script_entries =3D swu_scripts.split()
>>> +=C2=A0=C2=A0=C2=A0 script_node_list =3D []
>>> +=C2=A0=C2=A0=C2=A0 for entry in swu_script_entries:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_entry =3D f"SWU_SCRI=
PT_{entry}"
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_file =3D d.getVarFla=
g(script_entry, "file")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not script_file:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
warn(f"flag 'file' is empty for {script_entry} ")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue
>>
>> Can't we default to lua, just like SWUpdate?
>=20
> You mean the script type. Sure I will send a v6. The script name needs
> unfortunately set=C2=A0 ;-)

Yeah, picked the wrong hunk for this comment.

Jan

>=20
> I will change the warning to info in that case.
>=20
> Quirin
>=20
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_type =3D d.getVarFla=
g(script_entry, "type")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not script_type:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
warn(f"flag 'type' is empty for {script_entry} ")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allowed_script_types =3D ["=
lua", "shellscript", "preinstall",
>>> "postinstall"]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if script_type not in allow=
ed_script_types:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
warn(f"flag 'type' is not of value
>>> {allowed_script_types} ")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_data =3D d.getVarFla=
g(script_entry, "data")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node =3D f"""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "{=
script_file}";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "{scri=
pt_type}";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if script_data:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nod=
e +=3D f"""=C2=A0 data =3D "{script_data}";"""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node +=3D f"""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "{sc=
ript_file}-sha256";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }}"""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_node_list.append(nod=
e)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_ADDITIONAL=
_FILES', " " + script_file)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SRC_URI', f" f=
ile://{script_file}")
>>> +
>>> +=C2=A0=C2=A0=C2=A0 swu_scripts_node =3D "scripts: (" + ','.join([n for=
 n in
>>> script_node_list]) + ");"
>>> +=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>>> +}
>>> +
>>> =C2=A0 # convert between swupdate compressor name and imagetype extensi=
on
>>> =C2=A0 def get_swu_compression_type(d):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYP=
E')
>>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>>> index 1c94699..88faf23 100644
>>> --- a/doc/README.swupdate.md
>>> +++ b/doc/README.swupdate.md
>>> @@ -21,6 +21,92 @@ window is still possible.
>>> =C2=A0 If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is a=
lso
>>> stored in
>>> =C2=A0 the `*.swu` file.
>>> =C2=A0 +## SWUpdate scripts
>>> +
>>> +It is possible to add
>>> [scripts](https://sbabic.github.io/swupdate/sw-description.html?#script=
s) to a swu file.
>>> +
>>> +To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
>>> +The content of the variable has the following pattern:
>>> +`script_name`
>>> +
>>> +For each `script_name` the following flags need to be set:
>>> +
>>> +```
>>> +SWU_SCRIPT_script_name[file] =3D "<script_file_name>"
>>> +SWU_SCRIPT_script_name[type] =3D "<script_type>"
>>> +```
>>> +
>>> +The optional flag `data` can be used as an script argument:
>>> +
>>> +```
>>> +SWU_SCRIPT_script_name[data] =3D "<script argument>"
>>> +```
>>> +
>>> +The file referenced by `<script_file_name>` is added to the
>>> variables `SRC_URI`
>>> +and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a
>>> `FILESPATH`
>>> +location.
>>> +
>>> +The mandatory element `script_type` can have the following values:
>>> +- [lua](https://sbabic.github.io/swupdate/sw-description.html#lua)
>>> +-
>>> [shellscript](https://sbabic.github.io/swupdate/sw-description.html#she=
llscript)
>>> +-
>>> [preinstall](https://sbabic.github.io/swupdate/sw-description.html#prei=
nstall)
>>> +-
>>> [postinstall](https://sbabic.github.io/swupdate/sw-description.html#pos=
tinstall)
>>> +
>>> +### Example: postinstall.sh
>>> +
>>> +```
>>> +SWU_SCRIPTS =3D "postinstall"
>>> +SWU_SCRIPT_postinstall[file] =3D "postinstall.sh"
>>> +SWU_SCRIPT_postinstall[type] =3D "postinstall"
>>> +SWU_SCRIPT_postinstall[data] =3D "some_data"
>>> +```
>>> +
>>> +This will add=C2=A0 `file://postinstall.sh` to the variable `SRC_URI` =
and
>>> +`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will
>>> contain
>>> +the following section:
>>> +```
>>> +=C2=A0=C2=A0=C2=A0 scripts: (
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "p=
ostinstall.sh";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "posti=
nstall";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D "some_=
data"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "<sh=
a256 of postinstall.sh>";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }):
>>> +```
>>> +### Example: Luascript
>>> +The simplest lua script has the following content:
>>> +```lua
>>> +function preinst()
>>> +=C2=A0=C2=A0=C2=A0 local message =3D "preinst called\n"
>>> +=C2=A0=C2=A0=C2=A0 local success =3D true
>>> +=C2=A0=C2=A0=C2=A0 return success, message
>>> +end
>>> +function postinst()
>>> +=C2=A0=C2=A0=C2=A0 local message =3D "postinst called\n"
>>> +=C2=A0=C2=A0=C2=A0 local success =3D true
>>> +=C2=A0=C2=A0=C2=A0 return success, message
>>> +end
>>> +```
>>> +and is added:
>>> +
>>> +```
>>> +SWU_SCRIPTS =3D "luascript"
>>> +SWU_SCRIPT_luascript[file] =3D "luascript.lua"
>>> +SWU_SCRIPT_luascript[type] =3D "luascript"
>>> +SWU_SCRIPT_luascript[data] =3D "some_data"
>>> +```
>>> +
>>> +The sw-description will contain the following section:
>>> +```
>>> +=C2=A0=C2=A0=C2=A0 scripts: (
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "l=
uascript.lua";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "lua";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D "some_=
data"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "<sh=
a256 of luascript.lua>";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }):
>>> +```
>>> +
>>> =C2=A0 # Building and testing the CIP Core image
>>> =C2=A0 =C2=A0 Set up `kas-container` as described in the [top-level
>>> README](../README.md).
>>> diff --git a/recipes-core/images/swu/sw-description.tmpl
>>> b/recipes-core/images/swu/sw-description.tmpl
>>> index c52372c..88cb475 100644
>>> --- a/recipes-core/images/swu/sw-description.tmpl
>>> +++ b/recipes-core/images/swu/sw-description.tmpl
>>> @@ -35,4 +35,5 @@ software =3D
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sha256 =3D "linux.efi-sha256";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }${SWU_FILE_NODES});
>>> +=C2=A0=C2=A0=C2=A0 ${SWU_SCRIPTS_NODE}
>>> =C2=A0 }
>>
>> Looks good now otherwise.
>>
>> Jan
>>

--=20
Siemens AG, Technology
Linux Expert Center


