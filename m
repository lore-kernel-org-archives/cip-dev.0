Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C7C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:17:56 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.72])
 by mx.groups.io with SMTP id smtpd.web11.87823.1740399470926175566
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 04:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=R9bgE1Qc;
 spf=pass (domain: siemens.com, ip: 40.107.103.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOfibxwwUQOjybBpc3B7oMLFkHAt0FEaTFqv0KfvarqZ0NFAXIN9tLsufPCwUTMxfzAeYiM0gNZWaz0hLUKbIGplJKTCnx3bj3kg2U0AuJClLITkaGyJkKf1lx2TwrDJlI6w4cUzyK8LIM5fBov+aJCzjS2jqRJTYwdDOiiyaWUxoWvhJMeUpqqM5vrtMKju0BywtxPm9L4ACB1O7glI2556wS0M4VcYdFcCxggWAT8TFYuiyodvuhtjA7oB4BcM+iBmkSwiE1rF/bJK0mKBjEQQCuC08/69C58nhlZG4TdZ97ZQnYwOj/LP0Fm968FbW9yvJlmgWkrCOuSkUoq3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=863HH12vrF5jZoU9hmimzjVPm/2tLNI96qfWsFJUCHI=;
 b=ZbdrCjQmSO8G8mfBOdgEHG6i0Ue62eG+j3hYGOtYwTHfnq4JXXprluoayGDiygKazHMZodNQaDqrNt+DprkkzZVfX8jnUhysUYYRSBtq7STYSnWiuJFSC28CvBXZymVmlw4y5shjxt9MsbaZtmlbmEehYIjB7r7n3KPVC/TF2dmrKMimkh/qXtE5vYfduVIFT5dObBCQtpOT8kXlW/LYn8EQurHbpSBW4/UvPtiJct1Tkxmy3iZ3UDbLjm6P4T4l3zGz9BgsFw9VDRpFxu+FA9j6K3vXOoCY2Q4/deX5r7rTXjZy68nKsOsw9B4ZoOZY4isB/1qC6wNPEScyhx9e8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=863HH12vrF5jZoU9hmimzjVPm/2tLNI96qfWsFJUCHI=;
 b=R9bgE1QcrWxeAPtigHjJcqHsdA/uAU1HUzp4gRiBso1JclugWBrmVxInM38q+8hAPSUKugbLFZb294ZbeMrHYv6HM9Vy3firxDjHy1J9u52VQdKA+aTnkoLTY7s8vQULGzYkLhmEUlAtgWuJdtxnew6tvJXZHcHQLFRQzoL4715I8fqK4E2iN1GLYPkGghln7/7IGoKzuS9cDI6HUp4B/Dn1HzYT4wbFL+kBQb4DdKt21Z4icpBz9Ehd5zIv+f/uMPEU+636uCEiCaUmOeWaUZqDazIM0Njd31C+zEF6wp809TtU2WhlZ/bs90rGMvJbhpiVlVgBik8rybHvaXPZtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DBAPR10MB4073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 12:17:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:17:45 +0000
Message-ID: <2010c1c9-c33d-48fe-911c-4d4dfdf46d0f@siemens.com>
Date: Mon, 24 Feb 2025 13:17:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DBAPR10MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 90294079-65cc-4df6-a4d4-08dd54cd3eea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TbiWVaQknU/Ggxx0Yy7H5sn6XMlTjEGfdcVugBknzNv/nfSYTVe2AMO7iPmd?=
 =?us-ascii?Q?y22c4A68Ig6PZknjvQ4ixvgO8+ACA5VR+8QzDlHOdiuLj7fyccZrpKViLwOi?=
 =?us-ascii?Q?nJxYaLmJpIV0R8VSiFnveV4mfHnjCSO72smZ1zkWCjBdcLSqB961d1eXXeb9?=
 =?us-ascii?Q?vSXeajL8stdysI//Sku41FrglM3uhNxYaTzcLLT36gfnKjL7JG6nyYkCN38x?=
 =?us-ascii?Q?kn2CBRHUawtz+rpug0lYWmPyrxN+ZzFDKXgnaf3j5CKSlvsZRKJpDE9AwW5v?=
 =?us-ascii?Q?xSEHz5ogFvftFN4lic8r9L9CNXXNrBeIyqSjtxGntqMSX67z1Sx8HXw2Eyse?=
 =?us-ascii?Q?wNuIqn+2eu5f6yKlAUqzDaEdQrFHh/yTcZCZSBY3OZNlUnpA5cXoG0uwrxJk?=
 =?us-ascii?Q?8rbTdYQDD2rH8+WAt2GBdqZNbj5Zv6xe0dsxYK8rO4rIBIyFQa0GqApLb6VH?=
 =?us-ascii?Q?IqlGYK5Jkb1NOfpOna5s8NE2MGh6eyHmp64JDzt+SQZLYPYrpBMKBstas1oM?=
 =?us-ascii?Q?17TcaJpiTGy5+a+Ij/HNN71Z0vhHI9Rh+b4/EweRBojouwjYXjWSU/vt1Fvi?=
 =?us-ascii?Q?9DcYT127m/OoJAFZY1W5fWtVCOoGSbMF3Ln8nAKGr9fhf2JJXLGJSBGF6at1?=
 =?us-ascii?Q?fwWKn9iz+GInv7OAb+2J1hmoxpj4E1DgeW05XVrhsOpxOLx+i1Gos8XbxjIS?=
 =?us-ascii?Q?VoAQ0F4/vM+HjSz/o4xHUPcKeGCgISx3105411osObiaVo2nNL3ZJsDxaGgP?=
 =?us-ascii?Q?qV0AFcc020gYQu7maQyBYgUFZWcBJiM1C7gwRfL73/VfC3fPXO12ZEDYkRY9?=
 =?us-ascii?Q?gt7EZWvPWNPTNHW+w1Ul6ZeH10aYqIhaU5wRwNKDUxdhwoGmLyzwH7ZWm/0q?=
 =?us-ascii?Q?wX8+DsfLA5D27Y6qqv1LnXqwlIbF4qsRWeYcPltkTHjut+zq5seUugftKLyB?=
 =?us-ascii?Q?Tsfy3n4fmxp2u2JuT8KuN2aUcyMkWAWmNcYxjLNQIrTaRhg/rXzw/BnDvEfp?=
 =?us-ascii?Q?NyNRYVYlSeDsIK3ojNrKgzpN15wKrmMmF9h1Fme63taNOVDESw2E/VzN0XYy?=
 =?us-ascii?Q?/7opZ/T1zb6fV+6cj2rlD6vSY73fVvBxNS6bUPXbS5y3uLAy1U/F3gMqEXoh?=
 =?us-ascii?Q?/6AM7ZmrZfpoVqEjpQBXY6S2PKjP389ZrvvcW96xrYNVmLi1lTd3X18LwZj3?=
 =?us-ascii?Q?HxPOcEYnbTt+jMGEss9Dc3FfYi/usO2oEfmYVtCJG+4RTiYrQvFAXRNK2BOf?=
 =?us-ascii?Q?SnzM6dqVxuAGUAw+NG3f624qSr1dcwJ6OOo8kApPvIadifSdgLjhNVrzoqPE?=
 =?us-ascii?Q?honJ80SNG+W/A0p5btITiD/36yAhwiQz8L6dBUPWeRJj8g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eSLIw3YojePp18oKuK4zKfiMT7l+iX0qj2GkXG/sity0KlYKbLafX4KW2GSE?=
 =?us-ascii?Q?o+GGidMpYBjjH4DLnC+c6hfybPqf9KqmnclE6Rm+86e73m4R13sfPj03mfje?=
 =?us-ascii?Q?s3tShNc4yYpMjE+c9K0+6OjDDJibehaeqvPDaVOYPSLelCVPeXnTcYGTlnSh?=
 =?us-ascii?Q?WVTAFVsLKXECT6Un2BZRUYEkPxf9/7ekWw6d3wknlVeFKYrX2Rb3D5SdL0YK?=
 =?us-ascii?Q?pGJnQTlhudR1cPwBs++JH5j9ajNg6j0e1tyAoUf+9FngGrf1Qhk+Z6Ihohiw?=
 =?us-ascii?Q?vUpnAUxaP0+MXWlweOuE2G0yBo6WuEByqlg2A7jaeKdO438dxvjRPF4jAdJR?=
 =?us-ascii?Q?tjtmel6JFZNcHL7TCn0/w80Us3iBd+TFxAX1zmWcr4/soNSrLvlSNBUGDuJM?=
 =?us-ascii?Q?SaKf4iSeS2yFBFzGkVg5GMBl3uF2J2BGm60aiy5qp2NbKCoume4mvdkWgVzI?=
 =?us-ascii?Q?bBm+cRzC2fFZNO4JSGLqRYYa9ILi9c8PHsILW0pb87eYgn1AqpN87+tj10Cj?=
 =?us-ascii?Q?xQIrqRpR2AhzS2+/RnzSaFieYy2NA51ocpDmiP8aZ4E0p7rZ0PyMlSD/JsSl?=
 =?us-ascii?Q?9zRVCls51SBg2/DZPJiL+lSsdid3nvkE8bS7DgPpR6buraK1ieE3H364AzDl?=
 =?us-ascii?Q?K0CANDfiXqni8ENMwkySvj6jN1sYgMrQ3jEqp0qqGNDpwtIhPLIt7t86BRJ1?=
 =?us-ascii?Q?2tV7luPge7Rq8Hqz0m9cDTf5AdbLHUDCMJjlso9B+Ziyj0b2TOPH4dQkcu4A?=
 =?us-ascii?Q?Oj829rPR+QOHQp3DUyDZOqfIh3b5SOBV1j2NnQNEEjGO9vojod2btUkxdij+?=
 =?us-ascii?Q?WrvxxUFLNxIBibHJpSBRRf9JfYlUxv/DY5HyTTTh5aIq+OqeHrB6cuUNguN3?=
 =?us-ascii?Q?l7new1Z2Yf/Lhpypmoj5F+3LhZ7znxMzTEP3eBc+ogtV5XHb01TivX7AIlJw?=
 =?us-ascii?Q?eILlWRjRBZ8/Sl9D+DhGs5i6F8TedLQvfneayoN9vCFy5JbLLORDDDvAtkys?=
 =?us-ascii?Q?wGIwdHqucFmqkDK9ewY9jRkcYOsMpE4pN3xku0otGoCwdWDxiQNtFp7BJQpp?=
 =?us-ascii?Q?/5jH414BNM9SSsX8HTu8wzI9gl8rtF/8aFobWepg2OMYMgJ5BxnOBFx9jWgS?=
 =?us-ascii?Q?oWcGrXAFFlJzspcg88LKx8j8a1PA8zPnDH7Kqp5MUGJ+0IunwbebsyY4fGdW?=
 =?us-ascii?Q?+JfUOPEN1lByUiC3DCednlh2wlKwJWpKsrAKJq99i6wXmBINifDUkfJOgV+/?=
 =?us-ascii?Q?Vh6S5ANq26MxWqXwG1Ygs6UkN/RYJ+UL3QQNBW/ZZ88/pOpvE9OLiVm5CCr8?=
 =?us-ascii?Q?UDsvcBeETigIJ0VL8Hf+OCZDKzzABhjAvEK3uofN/Ara9srj2GE3QeCbC1rZ?=
 =?us-ascii?Q?Aa5kz326suOPprdior1N/UyFJLsISmV3EHEDLHLvIhZfZLz5TmAM+KsCebGr?=
 =?us-ascii?Q?OS+gAcY++0cQ8b5xHVmC+ZgPYD6TYxkzbHsLPlqRh6TIcIAHWXbCHWHD+2zA?=
 =?us-ascii?Q?qBvagiIq8/+ACEbv7zOJ0mUymhNrx2MAfIeooueARmeTlbdEUW2W7NbKO2O/?=
 =?us-ascii?Q?VnNcWY5OZKzNp4oUUlpi0Z3ocZbSaegL+XFw79WPq8y7dvmQv7QB54tOIMKS?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90294079-65cc-4df6-a4d4-08dd54cd3eea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:17:45.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OcgHAJXFZTF+z1jq9nUQbLqR/2BCOYVY9w+kim2TD5mbdWBtSJypFjhnemOVrm2hnzXoQBYG3DqlSzbFxoYf7IrN62/m9dkVpJObsTBZKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4073
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 12:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17891



On 2/24/25 07:09, Jan Kiszka wrote:
> On 21.02.25 13:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Heinisch, Alexander via lists.cip-project.org
>>> Sent: Montag, 17. Februar 2025 11:00
>>> To: cip-dev@lists.cip-project.org
>>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff, Quiri=
n (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Heinisch, Alexander (=
FT RPD CED SES-AT) <alexander.heinisch@siemens.com>
>>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from =
read-only-rootfs's fstab.
>>>
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>> Since we only support erofs and squashfs this option is not needed any =
more. Further, it causes potential overlay rootfs variants to be remounted =
read-only.
>>>
>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>> ---
>>>   classes/read-only-rootfs.bbclass | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootf=
s.bbclass
>>> index 35a3ab3..83ddc33 100644
>>> --- a/classes/read-only-rootfs.bbclass
>>> +++ b/classes/read-only-rootfs.bbclass
>>> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>>>   image_configure_fstab() {
>>>       sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF  # Begin /etc/fstab
>>> -/dev/root	/		auto		defaults,ro			0	0
>>> +/dev/root	/		auto		defaults			0	0
>>>   LABEL=3Dvar	/var		auto		defaults			0	0
>>>   proc		/proc		proc		nosuid,noexec,nodev		0	0
>>>   sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>>> --
>>> 2.39.5
>>
>> We observed `systemd-remount-fs` failing in a downstream layer.
>> (using a ro squashfs and apply full disk encryption on top)
>> Although, the service is executed in isar-cip-core as well, upstream,
>> the service can be executed successfully.
>>
>> In essence what happens is that, the `systemd-remount-fs`
>> remounts various mountpoints based on their settings in
>> `/etc/fstab`
>>
>> ```
>> root@device-mgmt:~# cat /etc/fstab
>> # Begin /etc/fstab
>> /dev/root	/		auto		defaults			0	0
>> LABEL=3Dvar	/var		auto		defaults			0	0
>> proc		/proc		proc		nosuid,noexec,nodev		0	0
>> sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>> devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
>> tmpfs		/run		tmpfs		nodev,nosuid,size=3D500M,mode=3D755	0	0
>> devtmpfs	/dev		devtmpfs	mode=3D0755,nosuid		0	0
>> # End /etc/fstab
>> ```
>>
>> Since `defaults` in fstab renders to: `rw,suid,dev,exec,auto,nouser,asyn=
c`
>> the service fails trying to remount the `squashfs` as `rw` as shown belo=
w:
>>
>> ```
>> root@device-mgmt:~# systemctl status systemd-remount-fs
>> =C3=97 systemd-remount-fs.service - Remount Root and Kernel File Systems
>>       Loaded: loaded (/lib/systemd/system/systemd-remount-fs.service; en=
abled-ru>
>>       Active: failed (Result: exit-code) since Fri 2025-02-21 08:55:39 U=
TC; 5min>
>>         Docs: man:systemd-remount-fs.service(8)
>>               https://www.freedesktop.org/wiki/Software/systemd/APIFileS=
ystems
>>      Process: 7530 ExecStart=3D/lib/systemd/systemd-remount-fs (code=3De=
xited, statu>
>>     Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
>>          CPU: 15ms
>> ```
>>
>> ```
>> root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs
>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-remount-f=
s.service - Remount Root and Kernel File Systems...
>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /: ca=
nnot remount /dev/root read-write, is write-protected.
>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:        dmesg=
(1) may have more information after failed mount system call.
>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/mount f=
or / exited with exit status 32.
>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service=
: Main process exited, code=3Dexited, status=3D1/FAILURE
>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service=
: Failed with result 'exit-code'.
>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start systemd-re=
mount-fs.service - Remount Root and Kernel File Systems.
>> ```
>>
>> The rootfs is mounted as follows:
>>
>> ```
>> root@device-mgmt:~# mount | grep " / "
>> /dev/mapper/verityroot on / type squashfs (ro,relatime,errors=3Dcontinue=
)
>> ```
>>
>> I understand why this happens on our system, but could not clarify why i=
t does
>> not happen upstream! So any idea, welcome!
>>
>=20
> The same issue happens in upstream: secure boot on, data partition
> encrypted, remount-fs fails. Which makes me wonder if our boot tests
> should check for failing system services...
>=20
>> Nevertheless, after rethinking this patch. Maybe it was advisible to not=
 use
>> `default` here and either use a options like `suid,dev,exec,auto,nouser,=
async`
>> or drop the line for `/dev/root` at all, keeping the mounts as they were=
 setup
>> in the initramfs.
>>
>> Any opinions, recommendations, hints, ...?
>>
>=20
> According to the man pages, a left-out rw/ro means that mount will first
> try rw and then, if it fails, ro. That would give us the desired
> flexibility. Hard-coding the other values of "defaults" is the downside.
>=20
Will no also lead to error of systemd-remount?

> On the other hand, what would be the mount options that the initramfs
> will use? We do not have direct control over them as well, do we?

The initramfs in standard Debian contains the fstab - so it would/could=20
use the options from there.
>=20
> Quirin, other reasons why we want / in our fstab?

The fstab of the readonly rootfs is an evolution of the original fstab
from ISAR. It is also there as we disabled the fstab generation from
wic.

>=20
> Another option: "ro" a parameter of read-only-rootfs.bbclass so that
> your scenario can override the default.

I would make it to option for all the fstab options.

>=20
> Jan
>=20
Quirin

