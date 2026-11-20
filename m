Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4476.1795176076368822144
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 04:01:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Sfqb2Rt5;
 spf=pass (domain: siemens.com, ip: 52.101.83.19, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb0Ykkk5wM1cyXcpB34rIPOlRyHPzQo7na9koM7dg3yDyry4McEVdz4F2bu9QfLs+X550Pi7wQ3T6njfNY9CtQb91cArBd+4Ixm6MZuMG11xQn/N5I2Ok6J5EXwumLCdCj+fLvDmq/7GzVHTHpIDRFqKL2bUariHRBJvkxJ1BympwRtZJX4GNx1ISuGZsrtFbzDgv4HZaubCs9x96irKpsNFC+enYtxcO0x9P2nhxO6qgUnY93uMqF51pXqnAX0ry+vGONo2lBfq+DAjzuJ08jVYXmEuIshwT5LiXsRAI08D1oMoEivF0xpjcLk4qMrfwcfHgMNLCa0taBOxpQLt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYlKx4SZHABbbiJ2OTQhm5BpE9YmMPw8P6eZinQmgf8=;
 b=kiZZzS6oYUMz1r5Frw92IRv/loClh/ldjdIamQGOEvOnS4qZtE+mgCa4c8X2zlDHNE8x4PMGeMmeFmhtiVNIW7CHtWLBQUZ+T1ZM9dOiREcRLXqrbyE2VFz6VY2BPs4lm2Mlr9uClXOOuphQdZEiZoWRPwXckqZul8po9MewePIcIb2BE2i/J4rKh8McGN8gk4fphh/L39aw+nrUY1OnsgLnAUjYQhi1kCzmYerM9FE7dlXHoqp/1/aXdSuhVkyIZ01Yz8+jbg62Io3SsFjhh4+fkE/NbP6tqRALY8GIEqJmpSwiPnnpHvmdeHw3sd/zK+1Bhog2kiRUTqUp/+DyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYlKx4SZHABbbiJ2OTQhm5BpE9YmMPw8P6eZinQmgf8=;
 b=Sfqb2Rt5+SMv8Rnh99XK+yK9lQS+t5bKEe71mLoZffV7v5BZSNymCxbIKkrSRbo0hyO5LpFPOJc5gZEBxzKDyT/sXxlF4SMM8X8uvqQX4ClPgPh33eUYgeVyUhTuTfjt5MOdaWIO4iI0fPSfYhI2k+omYxGCT67mxnJoNlCxswtFOyGXBreb+MCwAVq+wXrRBovpIKybfm9uGC31YkAXb66eWQhIavct7L21iQX6J+hglv/+z1gOG84WbPQvki0VMMcRbIsu+z8J0ZFg3ceZ5vR/wBLr6uOktt/i46OXcW740qSlU+AqFM8YKO8iZkSoNF/LahXQAdp4X2Z+ZxcuCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by VI1PR10MB3743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 12:01:10 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 12:01:10 +0000
Message-ID: <5a903376-5387-4836-9878-12db2e79afab@siemens.com>
Date: Fri, 20 Nov 2026 13:01:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Best practices to write CIP kernel details in a SBOM?
To: Dominique Martinet <asmadeus@codewreck.org>, cip-dev@lists.cip-project.org
Cc: Akihito Irie <akihito.irie@atmark-techno.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <av-icExXuq2zIc1g@codewreck.org>
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
In-Reply-To: <av-icExXuq2zIc1g@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|VI1PR10MB3743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9ad405-2149-4649-e7a1-08df46fdf7bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|261009223027099003|55112099003|11063799006|56012099006|261028144727099003|261102123227099003|261102130727099003|261026135527099003|261026121527099003|261026140227099003|261022105027099003|261022113327099003|261022075727099003|261021133027099003|261022115727099003|261021123027099003|261026130827099003|261021121427099003|261021135927099003|261021130227099003|10067099003;
X-Microsoft-Antispam-Message-Info: sma4EzYfUcREt2Ah/T3E7dvrSII3BZI1jaA417j85YjwIbMGC2PxgJqLaElW4qdknKf3pw7W/S/pY1fzZvxjkF0u22JcpJS2c/kDL42wXWsMQg+QkvoTRHqR8+kKTWQe/fUx/c/wQv9bv5SmN+HnrM+T8piq5oqhju+EGDir1BYrNBhemheAWKoRVTQ5WuF5hLKMhW0A4l0ZRz5TTGGcxd39KjdhM7aANe/Ouh6BmIBDj4N/q3HgH15tD9Qom83EgqMDucImrRDQwu8nyfQTAoa/qTyOvOS9+v2Qp867qW66n0V2NGIMYlzWxPDm3nskpBuDiNV7x97osAW3eX/QYcK34SVcHgJ3giVB+aWtI8NKmbKT28Y86wBSQ6l4HKYqH3LBlz5QwKXkhIhrxPYTmuwJQbO+WexBAf/lFGtw503wgmJ7omZMIlSkvau2cilYvHXgTNnrw8Sv6Z/qtQsALuWXockwSvPDLdXrrauBQApJZedLgAs7TzSl8zos6479B70gSzXxpM0XKaSm9x0XUYPd2MHarmKM3YeaSQuXYXgG51ciWWiqQz5JRlssBc3aNp8BXfCWulnXQcxd2FftGGB/4zZHxTn4dtwEiWtByeJrywHqqT0PSGPo5oO3EFAI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(55112099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261102130727099003)(261026135527099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021133027099003)(261022115727099003)(261021123027099003)(261026130827099003)(261021121427099003)(261021135927099003)(261021130227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBSOHZiQk0vQ0dHYVAyUHZKdkVWdjVEUWk0aTlqUTh1TjA4UDdQYmN5dUVO?=
 =?utf-8?B?b2JWZTcyNUdGWnNnN1hScDFGaVd6TXdSTnBKQjZoOHgzYzM5MlA1L1h5N3JV?=
 =?utf-8?B?TEwyc0YwVytPK2tyT1RhUTFTbjFRb0tSRjQ2dUZobFBaOFBkQTcyd3ZBYVNL?=
 =?utf-8?B?S05qbU5KTmtjTHNHZWlmL0FheGdYSkxLYmt6Y2FXc1IySEg3Z2RLRmhmbnJM?=
 =?utf-8?B?alhzY25pQmViQndUNW5abkdyK2dPNGpRaWkrc0hEd09BTUJqR0JyV3dOcmdy?=
 =?utf-8?B?eHg3Sk1vRlZacHJNOWFjMUdEWi9ac1habzBPVjNBR2dkdWkwaUJINm5wTmV5?=
 =?utf-8?B?QzZjMGpHaVJIeC9idTVHR0EwelFQK1FwQWduZmRmL0RvK3RxNWdZTmdDSk1H?=
 =?utf-8?B?b094OGJXYTRGd2lZSHUxU3BxcTlKOXlySlBwMWRlMm1kZDVqOVZ3Zno5YjZl?=
 =?utf-8?B?Tit4MTJoQXEyellxckhRSm04THFYSE10WDFmRE5mdVRMTUs3MmJTanA1ZjRp?=
 =?utf-8?B?U2ZGTFAzc3VrbU82aDM5c0R3UW9JR0V0Y0R5Z0xVdEJBWTBjZnl3MTJ3K3VD?=
 =?utf-8?B?cHZzVG5URVU4TmlNdi9zNHlxUC90bVpwMG5tMGo0WjBSaUVkbDBXOWRobENv?=
 =?utf-8?B?RGNTejJjUFNtbWkwcnIrMWw2T3hPYXFLbmdDejRBZHBNeDlSM2JxNHVqc1hM?=
 =?utf-8?B?R0UwcHNUMW16ZVhKbzB3TEd3NE9tODEvN3hDMlZPS0F0V0NZcDRUbkVneE1x?=
 =?utf-8?B?OFNycWpFbFVLWkRRMFRMeWV2Qy9JS09acGtLN2FYMVZqY0FZLzNNM29NM0ZC?=
 =?utf-8?B?NXR4S2Jpd3F5UWtsR1VsalQ5MTRMSjY5bjlHcnhDeS9EY0tRN1MzT2k3ZXIz?=
 =?utf-8?B?Ymx4SGZXSlZVVzZJUTU3QjEyUCtVMnJuTmVraWJXYjF3UjFPNEFLRTdlK2tN?=
 =?utf-8?B?eTAyaTlmTGZRdS9RcnJsK1kzSnNyRHpTNllNZzdjVFNuOGd1azVtcUh1Vkp5?=
 =?utf-8?B?VWs3cXF2NjB1N2plTWJBTXEvdTBha0E1L3J2dWlaQmxIQTg2ZUhCakMwNTJM?=
 =?utf-8?B?dWxpR3pXZ202aUhZTEpkL255RE1XR2JqdUVnWWpnNU1LUjZWNUVDWFdxckhI?=
 =?utf-8?B?VU9CWktSYnZpUWdsQ2xLSlpNdEcwclZDQzZtS3NsRkllbnpkOGxoTXJzYXBR?=
 =?utf-8?B?N0dXcTJpSzJzcm04R2FRZUY2VjRMVTViTFUraWZvN21OOEJwVmtxSC84THpL?=
 =?utf-8?B?dVEwckF3STdLcmpsSHVjUjc4ajZTQVZlTVV1d3hZb21GVGNnWXdIbWpwOGpZ?=
 =?utf-8?B?NXVHMWJ6T2ExdEtJVDkxMkg1andtQnFUVkQ5ZXZ4TXZzUDYwTmpGRFhZYXZ3?=
 =?utf-8?B?UFZvSGhOM0hZSGlTNnNMQXduYWFWUXFFMUFzZGdwWVlIRFBIS0dFUXE1cGY5?=
 =?utf-8?B?YkxjcGdHdGx6dDZYa3ZObHlTVnJkQWpqRVFUZXI1TDJHTVdtWVFGaTFhUHk2?=
 =?utf-8?B?OEZLMDZ6RXRESXpFWjRaSndkdVB4dWZmVnpBWFlTRTZXbUpiV1hEQjJkWmo5?=
 =?utf-8?B?bUgrTjdCN1NLZCtCNHhVczVGbVV2VUFFeFJHUWJKK280RGY3NmJaam5NakZL?=
 =?utf-8?B?VDAwNEV0ZkdqcXJVcGhDT2tOWjJiMWs4cDY0Q1JhbFYxTUs4Tnl3OFVtN1VV?=
 =?utf-8?B?Y3JUTVJnVnp1ZlJGa2hBK1c3TGtxWmdyNHU4L3Z5b3hEeWJZMys2cjNqMG5G?=
 =?utf-8?B?UXBsbFlnNDFSVnc3cmlsdFFhU3JQZ1MxZmVmT1poQU1FMGZJR0RlQzE3SDU2?=
 =?utf-8?B?aUJNQ0R0K0VVSzhpRFNXd3VXd2NBNUJyQTFJVVEwYUdmZWdGSHEwMXBWVjQ0?=
 =?utf-8?B?a2E4MmtaQnFDZVRBZFhqZEJ2S0FPeE9xQUVUMnpnREMrOHdoYWprZVlTbU9G?=
 =?utf-8?B?TUNoRjMxOWh1TTA5MkRpVXVFNEZXNFRnb2ZKZG1qNVkvVzJTdkFuUjBPM01u?=
 =?utf-8?B?dEZxZ0FOVE5QNVR2K2RPZWV6NUU2UzdleERzR0MyK2FTbGFoRFdrcU02VHRH?=
 =?utf-8?B?MnVjWkNHb0Z5dUdqN1pyN215aDhjeFN2bjJTd1ViU2ppR1Fkd1BXYUVqQXQv?=
 =?utf-8?B?MU53RlN6WW5IcmNueVFQbEtsb1RjSUxpY3FDY3BVd2xEOUZ3MHdBYVY3eFBJ?=
 =?utf-8?B?dWlTY2hBR3BRaE1VY2VnUlJCTWFveXBoc1d2bDhyUVQwSjNnOC8vK1kxZlov?=
 =?utf-8?B?YVBVdnpQTkdpK0FYRHJUd1VRWGNqck1aYW91aGhiYlgxeVVNYTRKUUkva1Yv?=
 =?utf-8?B?eStQRndhYzBNZUFzSEtPQU9Oa2VRTEhudmpPN0prUndTM3RlZ1cyb2JTaHVZ?=
 =?utf-8?Q?mDaMEIHuG9prGx4k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9ad405-2149-4649-e7a1-08df46fdf7bc
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:01:10.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj9H0MXQcEdykIiQQyzTHk6QBou41EIdXUZnpORnxtCQSXZi5ncJhwS92uZZP3W/Xj/czxlIYz7Tq4vHPYJq44+ezaBClcCvKccKEVKA5ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 12:01:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25043

Hi Dominique,

On 11/20/26 2:29 AM, Dominique Martinet wrote:
> Hi,
> 
> I asked about SBOM on IRC a couple of days ago and got told "mailing
> list" would be better - I hope I got the right one.. :)
> (also note: my org (atmark-techno.com) is not a CIP member as far as I
> know, we're not using CIP kernels yet but we do maintain a 5.10 kernel
> and I intend to participate at least in reviews/testing starting next
> month when upstream 5.10 goes EOL, as I've been doing with upstream 5.10
> stable-rc tests. If it's a pre-requisite for discussion please let me
> know)
> 
No worries, you do not need to be a member to join the discussion ;-)

> Now for some more useful background and questions...
> We're working on improving our SBOM, as it becomes mandatory in various
> regulations, and in particular the linux kernel has been difficult to
> describe in a useful manner so our users (we ship an OS) can act on the
> SBOM.
> 
> As long as we stick to upstream kernel stable releases, we can
> apparently write PURL/CPE tags as follow:
> - pkg:generic/linux-kernel@[version]
> - cpe:2.3:o:linux:linux_kernel:[version]:::::::*
> 
> and since the linux upstream CVEs are fed to NVD/OSV databases then
> scanners will pick up the many CVEs still affecting the releases, so one
> can triage them and export the result as VEX as seems to be the current
> best practices; but if we don't provide a VEX there doesn't seem to be
> any way to describe the kernel version as e.g. v5.10.272-cip79 with all
> the fixes covered by CIP automatically covered.
> 
It is true there currently is no globally understood way to reference 
CIP kernels. It would be simple enough to use something similar to the 
kernel e.g. pkg:generic/linux-cip-kernel@<version>. The second step 
would then be to start integration with all the scanners. I dont think 
there are currently any efforts in that direction though.

> I've found about cip-kernel-sec[1] and kernel-cve-triage[2] and we can
> use it to automatically check boxes in a VEX, but would it make sense to
> publish this data as well somewhere so that "standard" scanners
> (dependency-track/grype/osv-scanner/etc) automatically do it in the
> first place?

Is there any information you are missing from the data published in 
cip-kernel-sec? It is not integrated with all the scanners, but I think 
everything that we need should already be public.

>>From what I've seen it's possible to setup a data source for OSV.dev
> that they'd pick it up[3], I'm not sure if it'd be useful for CIP as a
> project or if it's something that'd gather interest?
> 
> [1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
> [2] https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage
> [3] https://google.github.io/osv.dev/data/
> 
> 
> Just to be clear I'm not asking for free lunch here:
> - My main question is, if people here publish a SBOM, what do they use
> to describe their kernel to others, is there any recommendation
> somewhere I didn't see?

I actually posted a lengthy idea about including kernel SBOMs as part of 
standard CIP kernel builds on this mailing list yesterday, but that is 
stuck in limbo somewhere.

Since v7.2 the mainline kernel provides scripts to generate kernel SBOMs 
[1]. That is as close as we can get to a standard way of describing your 
kernel, and it is conveniently already in the correct format for all of 
the compliance stuff. My suggestion is to backport the SBOM generation 
to all CIP SLTS kernels and generate them as part of a standard build.

The kernel SBOM can also be used for CVE triaging, very similar to what 
is done in kernel-cve-triage. Yocto for example is using their kernel 
SBOMs for exactly that purpose.

> (I saw https://github.com/siemens/debsbom from cip-documents, but
> there doesn't seem to be anything about the kernel there)

I maintain debsbom, so I can give you some insight on what we are 
currently planning to do.

The kernels in debsbom are currently only referenced by the Debian 
package that provides them. If we have a kernel SBOM associated with 
that kernel, we could reference it or directly include it. That way 
everything would be connected and you have a clear description of the 
kernel that was used in the distribution.

> - Are there any plans going forward for kernel? If so is there anything
> we can help with?

I hoped to start a discussion about this exact topic with my post 
yesterday. @Jan can we do anything to get it unstuck? I can repost too 
if it is not recoverable for whatever reason.

> 
> 
> Thanks!

[1] https://docs.kernel.org/tools/sbom/sbom.html

Christoph

