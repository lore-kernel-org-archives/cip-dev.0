Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB67CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 16:37:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21036.1764002225663899703
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 08:37:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kr2NMA7Z;
 spf=pass (domain: siemens.com, ip: 52.101.69.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOXUCy4xWF/H3ZdZNZlQ6dOogmN0ogu0uj9ffKYnGsqglMN52kFmOvaGUO7kKLvUVRSyZDoAfzzp8myYcjD9isPKqp724Av6ALoLN2DPckteanioywYYDRdiZKEBB887LirEQBsmjUcGR4sx7h7T+kJfOGCPY9FFPLhAU7aImHPFQGajlvT7iOFOXZBnIppmflvpf2FSi6Bn72TeBxZq6TLEaMxwv4Pp/udlg2DgNkQfokUZf+ox33DrCyYdwFEOmoYczD6Jl4aov1GppK62JdI25l5AYPczx8kEOLl+M7fN9wFSkD50vSHr03xSlhkYQjOBmNRLhoi/LoAVaaW7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CViDeMv1ttanlo0rnFWo5cSX+hIcaJbtbCzN2N8aep8=;
 b=GPWMoqwMUSSMOnGqH2mA3oK1hLyT076fkyMKYmlHpeG1dHiukUuUyQAx5U6AK/Jd5p0r2fZ53Y9fN4Apqb8goCZpydenBUp4I5sj8Du/BunijPSFuZtbWeIYxwWjyuXAR5up6GH6cf5oFVtGNK0KCfjg0YtReGS3GJXOEzctKwlqr2nzlcc+5EJ7yQz6H36uSgKH4THJpTKOCNyqAl3MTetsFKsWVEWeVimsLrhAHY+USycw+/Ss82C6x47GJgU52xISVqyDq5Q9QNVL1TToqx6tDSKlZ0Y8kWim4GAovltxBs08etjKGL5p0HIKNmq0oLpLaTu2U+syAfpH6C1fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CViDeMv1ttanlo0rnFWo5cSX+hIcaJbtbCzN2N8aep8=;
 b=kr2NMA7Z5ioXhfIwJD/xtyV44lZKeLtryuN9d5IooWIMIQqTPNuxRAdAnkOKC0oEj5FBOkhMRvZzfWlOjlYXtv3vLuMc57xVxkjIL7BuAIvy24j0A8USMvz0VFrUrAhq1WpmvNMlFUQ2MM6RAW2mudrJmWqWJ1mCw+3Gw+TTVhZ7fSZ9uGi3Fctpj8A4Za1m7nAgoZtbKg4EikKALKDI1CrQQXh1Do9Q1B1qzk43Zm4zSzHwG2H9c50BpENV1uRFmA0huAeQcVv0nrLYDMoj3OYgRyJ+9lqEYyeKM0woXNQOnsqtWMHRpoYAoX3t9jE17oaUJwLu5iU3uTL0IR77gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Mon, 24 Nov
 2025 16:37:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:37:02 +0000
Message-ID: <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
Date: Mon, 24 Nov 2025 17:37:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
To: "Singh, Gourav (ext) (FT FDS CES LX PBU 2)"
 <gourav.singh.ext@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3996:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f7415c-2bc3-402b-8cde-08de2b77b21d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejNoaDJHY0tORXdWYjdFRFVCenJsUkErVjlOUGRUUnNuMmgvckkxc2luWW5J?=
 =?utf-8?B?TlExL2pnZjltY2x2R0l4bDg4eUFWb0wxR05jUmErZmhNUkVJaFVYU0lTbEt1?=
 =?utf-8?B?UnRzbmIxN2VjSGpDWTlLZVlUZzJ5SE9KbEs0RUhkSFFHRWlHdVRNcU5mc0J2?=
 =?utf-8?B?V2dWQVlScnVsWW9QQUhCWUYwQkVscHNHZFRpbzJBUjRnQ0pPMWRzTk95N0hB?=
 =?utf-8?B?VDR5ZkxvZjhQaFg5N2gxczdKc2JjU2svRC8xdGszS1d3VlJyT0orS3ZRc1hr?=
 =?utf-8?B?YTQvN3ZvcTllZ3N1MXJjcnpNenV6VU5BendYdE1xNVRLVEpSa2ZxQkYwWkh1?=
 =?utf-8?B?L3VjVWdnSXduNzR2aFBlWWR5QlcwS0JvZ1JhWmdXUitqNmgrTFRVbnBoSEls?=
 =?utf-8?B?NDlIWS9OUW52RVNJUVd3aVVLM0lSaDg2aFExbXZOS3R5ZUlhbW1sN2V3cUhp?=
 =?utf-8?B?ZjNjVWh5V3Ewam1TejM4YXE1dU5Ib0pOUVVHRE5nbVJvVEdMSjYyMVp4aGFJ?=
 =?utf-8?B?Q05aZTI5SFRYZmI0bDhOOHIzZGk3Q0xYQzRHOUdrSzlRRDVuV1ZRdXlYbWZP?=
 =?utf-8?B?enZzZDBrdHdqeS9iWitUNkZrWkEvVmpCdmJUc0tSVTI1TGdIU0hTNTRLckdK?=
 =?utf-8?B?QmZkTDBQbWZCb21wWkhlNE0zUk0vNWl4Z1QwRWRFMjB6blhkSXNCNXkranVK?=
 =?utf-8?B?Sk9PcGlLcGpLajNjaTNjWTQ5UlVNTmswWm44b3RteGE3Wm5UdU5ncFhaQ21i?=
 =?utf-8?B?OEdvZ3ZYeTZsVUlDb3hmRi92RTNwSjJHTlEvS095c2lMNnJReDBEQ1hsbFBB?=
 =?utf-8?B?b2xFRWZvMHRZcTlaV3JNbDlITVBrUzNBQytyYmNqdEZhNVlDeTI2M3h4a0hV?=
 =?utf-8?B?T0Y3Skk2Y2NsaTI2QlFZNlhPaWRPbWlYN2luNHBLZzFJUnRvdHVGUWdKTVNB?=
 =?utf-8?B?VCt4alNTYzdHWmthQ2cvYUVRWXZOeEUxOXdGYUl2cGVuVHFqdndsUXhad3Rn?=
 =?utf-8?B?UUVCN2lrLyt6ZDJ3QUJ3c0QycVdWTFZRUlBQeGZYd096bXBLL3BsVTNCZGdw?=
 =?utf-8?B?SVpEVWE0QmFIaU00TTBMNTRYSFEwNlRqek0yYWhXdnZPSEdKRmkyL3h0MTlm?=
 =?utf-8?B?UGRmdk9tT2RQVnNrQ1k0dTAyb0VCZHJIZjFCazVuMzZ0OVNGbmlpdXhVbFc3?=
 =?utf-8?B?MUtYeThnbFRRMFkweVU0TkdKMDBBS01zTEpxSlQrUVphQmNtVkF2VURreUpI?=
 =?utf-8?B?cytuTVhUQWh3TlRBZ0kyMFhDN09TT0NMaFk4U2pRb0I5RUpmL1hhc3YrdXhl?=
 =?utf-8?B?RGpKbzFWTlorK0RYMkkzcGF5TUdFNXF3RUZ2V1dmTkZJd3d5c0JxbzhIQk15?=
 =?utf-8?B?NVlzOUNGTG5HQUNvWTZJVU5JVVZDSlpZVjNDYjdzUzI5bCtJemxQMWl4ZU5K?=
 =?utf-8?B?VDJ3ZVZGNmwwNVVUU09USllPenY2WlZXMno3UFYwMnZFN1h0KzFjVUIxd3Z5?=
 =?utf-8?B?OUhZTDVXeFFPMTZsVWFzS2oraUVmS0RKL1JRZ25BWmxvN2UxMWJLY3VTdWUr?=
 =?utf-8?B?K0U3ajY4dElyc0hxUkFtZzlHYnNkZm9LQm5HRThsdkZvTmFoMTlOZlBDTkJn?=
 =?utf-8?B?WDZiNitBcDJmU3JQNGJadXZ6NXRLaWZyVEY0SUZIa1lzTWFuenBGSktNL1Bs?=
 =?utf-8?B?TTZSZGxKVklwSVl5dWVHa1lYUzZYR0NmTHF2K1ExTTZFR3ZIMVY4Z0pLbTFW?=
 =?utf-8?B?VnUxaytOZ0tDY2w4bzRxZ3BFQ3laZ1g2cm4ydW43OUFJZStjWG5NRGMvUXo4?=
 =?utf-8?B?d3lvK3ZhSmZlTmpXTlZNZDJDa2QxcDRERjFJM0czV3ZURXhGTytkcGR5TlBJ?=
 =?utf-8?B?akpvWGpYQk5wQThMZVo5NUc5MWtiVTUybHJJSnJGcXk2K0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDNud2o4WHcvdUFrNVdwMmFEVDhnY2dMQTVHSVpuY01SaW9lNTMvSjlHSHpO?=
 =?utf-8?B?aEtmdmFjMWNzSytYa0lHWUxYWnAxWmNhbmdHYXRKbkY3NGdqUGppaTlLUXVE?=
 =?utf-8?B?elBLMmpPOGhHOUdKc3ZnOFFwRXFoemlKTHdTeENSOGtuNWhDcFJGa0g5UW82?=
 =?utf-8?B?YjJlbFN3QXZUbFBJUmVNMUhINGEwamJ5SlhKL3dIWWpwckVLNXZrMGxuWGJm?=
 =?utf-8?B?QzNtWE5KNWFLM2pLVThUamhyU0FqU2JRdjE4MUNMYzV4Z01IZFBFelRZTUZO?=
 =?utf-8?B?cmhveGs1enB0SytHczdaT3I2ZHA5T3dLTTNYbnZMNGlZUGllSkdxZ2srK0Jj?=
 =?utf-8?B?NURpMHJ6TGp1bzUraTBENnIrZCs2L1VLY2owa0hXSWRlRjhUOUo3czEvV1U4?=
 =?utf-8?B?RHcrK0owY2g0RGpJbUVkNVhLVFBtQnVHajYrMmZwelRub0hsSStKRUptSUVH?=
 =?utf-8?B?aUh5eW50R0t5blBzaWRQOUJxZG9EUHMrQ1k1Vmh5WjJWT0w3QVR5a2lCaHpP?=
 =?utf-8?B?VHhqKy9pYXFOUlZ6OVBXREN6cUU5UzR6WXRMdlNzdnlDYjBKWURYRXZ4Q1BQ?=
 =?utf-8?B?YWRZU0NtWmhRcEVVd2xZd21NV2J0VG45MW94MWg5NUt2N2Z2cVFyY2wzVGFF?=
 =?utf-8?B?WEQ3SW05RW44V0p4dm5rdUhkU3l1QklYekNsL0xJdEZmVXNUMkFabFMzditm?=
 =?utf-8?B?SDFqbU9lNkhhY0xVYW1wSU1RRFRhenlKTXJhaU1GbDFpclloUTdJSkM5YWNa?=
 =?utf-8?B?Ymp2T0RrMHZEMmxWTm0razM4Smpja3djV25uRTNLeEkyTU4xdzhmOHBkMzBk?=
 =?utf-8?B?ZjZCWmxUR3ZJajRjenhEV0xTZXllL1RPUXl1MjlleURYSVFWZS80YnNvdjZs?=
 =?utf-8?B?ZnFIczA2WVhBK0E1dnk4UEpScFhPc3RINmlSckpNemVUR3NRei93ZnI1NnR1?=
 =?utf-8?B?L3FmejRackQ4WllZWnE5dUpZSXlydGExNmdGMjZVSlFNOE5POEptOFBlcUFV?=
 =?utf-8?B?STJMQ3hCSXVBOCtvQ3cxOGk2OHNXSE9CMEZPQnlkRFVzUnc5MGIvRVpsZDdR?=
 =?utf-8?B?OXBIdG1nbmtFMkdpYitEc001NlhKcTloQzgzQWJ2R2VZaXkxaEdKY3hjNHEz?=
 =?utf-8?B?cTVOVHJBQ3N4NVR1ZDR2Ti9LbEhQOWdjYVJIK0x3VFhMbUVWTnhWOGVTeGo4?=
 =?utf-8?B?MHUxRk5sYWZUQlFhaEVkaS9MRDdyeHgwK2FwdmxBelQ2cGRNTlZoWEc0ZWZL?=
 =?utf-8?B?Z0Z4cHp6NStpdks3TDgyYUI2d2JMWmFBVys2NGdjQlR4WkNiMitESjJPYnVW?=
 =?utf-8?B?L08wRzBHUVJHNitRK2R2NlpTbkxFOGxDYm5SbWlibllsV2FZK3BJeTJ0U1Jt?=
 =?utf-8?B?eUJzUDJsWm96VFdYZitxZVNMcnhNT0VSeEZJQkNILzhaSlpmWFZkM0hYMHpT?=
 =?utf-8?B?Y0VyYUc0RGxXR3V1eGFkTEpqYzdnZnk3WVZDdU1ORXgvdEd3c3N1YU41TmFU?=
 =?utf-8?B?MUlZNllQYUdlazMvb2hsR3JrdXNOU3lLU1grOUY2Y2NrckhsSDZuTzVMOGVV?=
 =?utf-8?B?K2lxb0ZDdE9BcHYyRjBIRGpDSTV3cGtLSzVuRHkyYjdLelVzZWxtQldNWGtT?=
 =?utf-8?B?elFtR2ZkUW9VVTEwZS9kK0hnSWlsWDVFR3hScGxMbzJTQWxXYnVMdXc0cEpB?=
 =?utf-8?B?TUJLUm03N2lhNGl4dVQweTBBa3U1d05iOXJNVnluR0ZkZWlrQ0xQMGp1MHVw?=
 =?utf-8?B?N2FxWVhOZEt3aXFUZXZXdTc4YVFwaXBGRFJmMXpkLzE3dWp4QjRPd3dzTFg2?=
 =?utf-8?B?V0hiSytBaVg5MGpsYjJqZUdmamJMNkdLc3VPc2pLdkdsK2NGdS9CcFhlK0N2?=
 =?utf-8?B?bldwQll2NWJDQTBpUUNIMGlUVXkyUWYvY3RYTWx1M0xnNXp2d1FTc3BST1B1?=
 =?utf-8?B?Ky8xaFB2aStKU1lHZURka1V4Rm9LQXZPN2VEdnZXbmhhZXErdDYrVW5NdVlv?=
 =?utf-8?B?RXFZRG1xTFhBVG03OU82N0FuUmxxdm05d2R3bG01RXVobVNxdURGZUJPaEtZ?=
 =?utf-8?B?b3FLRUJQNkxFUjE0SThDNkh2a2xHVFJmS2ZmRUZ0YjVnK09WaFBLSkc5ZmhZ?=
 =?utf-8?B?dnlwUmZSNzgwcWsyb1R0bzZaTXREOFNlMHRZV09DZ3ZKQklKOTgyRVNvVVRk?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f7415c-2bc3-402b-8cde-08de2b77b21d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:37:02.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLWWrxspmvrVe7ymAVK+L5b+XxRItnFHRITlIO8V/tv0ZSGUne2GKF8hCOaha5c4tuXdpkg8CTLAjRE43OQV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 16:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20718

On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
> Regarding customizations or configurations for the `libpam-systemd` package, which provides `pam_systemd.so` - a new systemd mechanism that replaces the traditional `/run/utmp` for tracking active user sessions in Debian Trixie - it is necessary to ensure that `pam_systemd.so` is included in `/etc/pam.d/common-session`. This replaces the traditional role of `/run/utmp` in session management.
> Ref: https://lists.debian.org/debian-release/2024/05/msg00150.html, 
> https://ddp-team.pages.debian.net/release-notes/en/html/issues.html#the-last-lastb-and-lastlog-commands-have-been-replaced
> 

This all makes sense so far, and if no one complains, I will merge it soon.

I furthermore assume that our IEC testsuite will "just work" (again)
with this applied, right? Switch-day for the CI to trixiw is now
Wednesday, or more likely Thursday.

Jan

> Thanks,
> Gourav
> 
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com> 
> Sent: 24 November 2025 12:21
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in Debian trixie
> 
> On 24.11.25 06:06, Gourav Singh wrote:
>> In Debian Trixie, /run/utmp has been removed, so traditional 
>> session-tracking mechanisms (used by w/who) no longer work.
>> To restore secure and correct session accounting (needed for enforcing 
>> limits like maxlogins to comply with IEC 62443 CR2.7_1), we can add 
>> libpam-systemd.
>>
>> This ensures that PAM can register user sessions with systemd-logind, 
>> aligning with Debian's design for Trixie.
>> See Debian-devel discussion: "/run/utmp is no longer provided in 
>> trixie ... replacement mechanism provided by systemd."
>>
>> Ref: 
>> https://list
>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=05%7C02%7
>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C3
>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknown
>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=tNzGl6b239zR7
>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=0
>>
>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>> ---
>>  .../security-customizations/security-customizations.bb         | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git 
>> a/recipes-core/security-customizations/security-customizations.bb 
>> b/recipes-core/security-customizations/security-customizations.bb
>> index 717e2d3..d8fa22b 100644
>> --- a/recipes-core/security-customizations/security-customizations.bb
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS = "customizations, sshd-regen-keys, 
>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye).
>>  DEBIAN_DEPENDS:append = ", libpam-passwdqc | libpam-cracklib"
>>  
>> +# Append systemd PAM package to limit concurrent sessions in Debian 
>> +trixie DEBIAN_DEPENDS:append:trixie = ", libpam-systemd"
>> +
> 
> So, no configuration needed? And does this obsolete any other dependency in trixie?
> 
>>  do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
>>  do_install () {
>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf 
>> ${D}/etc/ssh/sshd_config.d/
> 
> Thanks for tracking this down. I suspect that our certification efforts are still focused on bookworm as baseline, but this is an important step ahead already. I also hope we can soon switch CI to trixie, currently waiting on lava-docker updates on the workers.
> 
> Jan
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

