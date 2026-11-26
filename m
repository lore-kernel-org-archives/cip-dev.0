Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8974.1795674549175513541
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 22:29:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mcyG2Z1H;
 spf=pass (domain: siemens.com, ip: 40.107.162.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1UZVz0yhimXTv0sBNa2mGONgYEV2amTjNtycVj1T3i0f+wM4ydc86UiCY8s41HMUjNxYjWw3F5KF/wdMpHSOJNp5RPpBwMkiq7F6Wtzk2jfsP0FDYGOWwvf9M0L8CigY0jjpSmyOI3alg1OAfbO4j7g3sQ6vY2gB3inipDYRow9AQ6hUXxTQTRH5MeiSpI2ZAnu+lYJfG1bGHwoGKdfbeaOz0inwDGOB2XwBnZ8ORqTvMjpw4RZWrRTG8lvR6uyIHy7Wu6vUEU4SisYIzTT5Qwlor0tna2GlXK5uHQ7njGNcF6dueeMYLtZHB0WQqOgux7ifk/aQEqMZY9lu00Gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSQM0WGbq+d7JmpDVuZ2NrDNiBWqD00gCGYmiHIez6k=;
 b=oeofLUvDZiJcBYZY4/xOooaqLujOMcMBZCBtGZFLVYvznE2fSW+QeFsPzyJTSV+xTBPBu8kas3msEiGEk4VekvpaNIpLqocosFOYHF9H7DstdIRA1FS2LdlngddNQTr0tQeKV1hqLV2VNbTyqn2YWwdr1+9/fZPRTReajKpX7MU5KJtTj3XXegW2qKz3hehYW+SM3I60hfc4BH+30M/uuXO2fOB8SrqVesGVCAo6pLkriFJgrsWzaeFhFJh8cM6GD4gr9fAZwyDdEzKyjgSZPVhKQ55MAOCwnVXcEKRwCN8LazktRvXDorH4kUeewrwal7JaI4p345lClHsB+a2t8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSQM0WGbq+d7JmpDVuZ2NrDNiBWqD00gCGYmiHIez6k=;
 b=mcyG2Z1Hdf862znUlI1F4CXzAlxa93qK7ULrKul73OHthaPyqVSAhHQM7z1SlG5txIoKM4kHNpQAXcp7C/jg8z32uJxYHyU0NFQUI0k1ktwpVKBrDG1lnkPSsNTtruyMBytPD/jPGF7v0NloIGKZB0ENxQXdBEN0m3Lnu7yggNEWyVdlh7W1zcQ++aoYkVfyPfyelsmUFeQtDWUJKpDVDO3UvCRnZPiodXjTn72wBGsFtxM0KZr1Tk3NgA+VmuM6iT9ozAb2k3V3acUlFfBlvbWDGOpG2+CGsmTzWienwl7LNhsdJv1lKdwInGYLQFnzNq159C1UCNmKnUIoCnBNBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MI9PR10MB992186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:89::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:29:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:29:05 +0000
Message-ID: <634f612b-fceb-4233-9d31-4561108f7ca6@siemens.com>
Date: Thu, 26 Nov 2026 07:29:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MI9PR10MB992186:EE_
X-MS-Office365-Filtering-Correlation-Id: 016c1ddc-fe68-46c1-ac0f-08df4b8691dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|261026140227099003|261022075727099003|261028144727099003|261021135927099003|261022105027099003|261009223027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: N5nPmMkhZbyoTupMIykVqqIXriOEbgtYf7VzvE1xsivEBIV/TYGR3IVdMK4ycI2qZEXmz0iaR3IFAMq8DkgryRAXdYdA4xodHzT/MZotAcuJbcng2/j+7F0RVizrHlVK7x3TcAUWNOzWe/dYdWs9klc3LlwXunWpB8U6tWrLb5WpmvcHfzVLgrhYuvWhD2BuJo0u9/g6RAfQlqpGEK+C3WJjrfohhGT+kh9HDjnyIQumbAhaAXsbBBxnLfnTNrTgVDXZXAp1a4V8MysAv8HMpwlc22uYdbZW2sjrqh3fD8Nqb2geKLlnfnSNGWeT18HRGHdybNwX3GgQwdmBnUMC8wBpEAnRpxJn4krx/ltA5E1MwvDtHOHuF9ABVmynFvPh5BlYFIGAMKuEZmbhGRcuWiLNcj/maZD3ukLT14wC4PQ2QNj7J5bLZIiCu3yEeg86qL8raOu6GXYt4SHc/M7jVs78WDgswRdJbdkUOiJYql9q6OpCKYnIaDNTTE5bAN/mopMICQqr/d2By9/tblUPrQUYfNuOTSd8ahtcgp1aq9gblei/KAQOGmgnzwRxkvpsNyppzx480qa/6ExOBYe5OU089ec9JPiel9Z73BE/eqh/jXRSfMV8ztg2UkYe2ts+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021135927099003)(261022105027099003)(261009223027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujd3aVRyUkh5b0xEZ1RBNkdZaVNKRklEUnZPWlE0UnJoV3BhTk91RXZmSWxZ?=
 =?utf-8?B?eGhNWmRCUVBKdTEvNGNPeXI0YjdXRWZUaHhhL3MzNVZVaHNlZEtmbk5aOXpu?=
 =?utf-8?B?WitNZHF5NFdXZFhRWENjR3M3YnY1THIwTkZvTWsvR3gvQnkyMU5BbVJnSjZE?=
 =?utf-8?B?bGxpN0plSWFNT1hqTjZZM290ZGNZNCt4c0ovT2NHSVZ6WUR5TXNaM2VQZkJu?=
 =?utf-8?B?ZzhiRXFSVXlrd2Z1YXBGeko2NzlYM0VuNC9yRGFmckxxYkV0MWVFQk96U0FF?=
 =?utf-8?B?bDhQK2NxU0EyOFdFQmlIZVpvS0VLSjluOXBqdEZZaXRrSDZSK2hsRFZRVzJM?=
 =?utf-8?B?VFVSMkgzRXBvcXQwd01lV3JsR2FaTVlLMXdjRExSZ1kvZUJUaE1zTGxBZjdZ?=
 =?utf-8?B?M2I3TjBva3BtZDI1NEQ5cTFPbTZYZEQ2UlhrTHFzYWhoaHlQQTN2VS82ODA4?=
 =?utf-8?B?djRKaDNTYnYxZlZtWUJHRytMWGJWNmN2dUZyZXBHVTMrYSt0Nkw1a0REY1cv?=
 =?utf-8?B?VWlDdXBocDVJYmp6WUNDa0t5dXUyV2J2bVpQQmtNR3BYTWRSYWpGblpuMmN5?=
 =?utf-8?B?OVlhb3NJZjQ1dzNITWc2MmFmSmhuRGhDVDF1dFZFenF0amtRc2t6VlJDOTN2?=
 =?utf-8?B?M0o1SEkxUS9vbVkzd0NYYzJiVlpJdkdHaEVieHNMV00yWFkvZUJJU0hRbTNF?=
 =?utf-8?B?ZXQ5NUpoelhwZ090T0dpNzhjZHlGeHk2Q05vdEZ6dTBYbGtCZXhaYzdBbTNl?=
 =?utf-8?B?dVEvWkErRlNIZDBFTGpCclhmRHdLdldyUVJ5R1dlbURxQVJZRFQ5UmlpaGxp?=
 =?utf-8?B?UWtHaEdLSXpnRGFRNUdJdlhUVDZ5UlEyVDNIYWhFN1ZYL2RvQUQ4bnlXWlF4?=
 =?utf-8?B?UlFkdnd0bXdadWRuT3ZiaDl0VTdtMTFha0xSTkxMSkQ3YlRodlAvcjVLa2VV?=
 =?utf-8?B?SFRnNE42SFZLY0lMZDRQZzNXWlcwTDlyS3crSGNjMzZ5Ykh2VENUMUdqM081?=
 =?utf-8?B?ckNzQ3ZSRk5vSXNsSisxeGhkemxtV01qcDNpVThDQTZTTkxvaXpGbTBjQXF0?=
 =?utf-8?B?Ry9JSkxkOVU0cFFSSXVJTi9SNk55Nmt3RjU5c2MyOHhacUprR1N1VDgwNlpk?=
 =?utf-8?B?WHNHTXI4UzRiRlVNREorZGc3anFiU1RoVUZOUGFFK2d6bnBwZlVNM3NKQ3ZE?=
 =?utf-8?B?VTA2dGNUazJwdkIxWjZ4NVB6ZSt3QWt5VjdjbDFTQ0NxUkJsZndLV2k0S1Ro?=
 =?utf-8?B?b21BY2lNUjcxaUxBWW5aaklxMGxkRmVtM3ZiQ1djaC9aaWVJclBNNFhIZllJ?=
 =?utf-8?B?cTdPQ0FiWXV6a21laS8xREFKZTltR0NrL0Y3Z3pCNE1IRy9teU02eDY4ekFn?=
 =?utf-8?B?ajhtYWk0U3ZBLzg5bG1tcE5MSDN5ZlM4R09uRlFzeWlTR1lmb1F6NUNJU2JT?=
 =?utf-8?B?OHJzZm50cTUwQ2ExY1VHaGozckhUWjV5bHNqaGNlSzJJelIvcUd1N25pMDZU?=
 =?utf-8?B?T3g0NVJ6K2dPNEY0SFpQTkNOQk5ML0tnNW1NcXJpMHNvUUdsdG1wMFh2enJv?=
 =?utf-8?B?bzhYNzhEZWhVWG93Z2xIYXFsR1g4dXJOMGdQOENZTHhQbnlGVFhYM3daamox?=
 =?utf-8?B?K3FQeFF1MDZBSjlQcDZuYUZ4cktJbVZVTmRDRzQ3VDdpQWU0V0QyTmppT1FB?=
 =?utf-8?B?cGo0aHNmRG9jTXBJK1BGTFdaQktXQllqREtsL0FmS1NyKzlXU2VaTHlIZENT?=
 =?utf-8?B?bnRUQjlFcExkY2tNeWx0Sm1rYzZ5S25FQUR0SlNtbGRBNlo2SG1oZ01XOGhH?=
 =?utf-8?B?eTBMZytRQnBEeUFhZkZuZjBXS1E0NEtOb3loaFdlVTZ1ZHhaNE9vSGk3VG1J?=
 =?utf-8?B?bmp1RVJXcjVSdEpmUWJLbzNCbmFyUlZJRmRhaWNrVFFPTHVaV05VV0dFQkJ4?=
 =?utf-8?B?akp5R0FGRVk2dThUNVFlam9hVTRGOW1ENENkRGFnaEZrRkFwOWh1Y3haKzE1?=
 =?utf-8?B?bTBsd1N6aHQ0YWg5YW9RNlJKREptT2JWdnRrTVZNWHdBRkgwY3RtcnFPTHNt?=
 =?utf-8?B?L0EwMFhKSlVxWUEyUUFvWThTeGtCYUVqVWNSdXA3TTRtdG41eTUyUjVZZmhR?=
 =?utf-8?B?TGsrd3BxWXFBUGVQNm5qQ2pPeEx3dTBpOFdiTDd5QWVTTVNJcGVheWwyd1hT?=
 =?utf-8?B?VnV3VUNYS1RQVVFNQTBFdGxsSFJlR3p2NW9JLzRtNXFYdk5rN2xIZnh1Y2F4?=
 =?utf-8?B?NytRM3BHdCtsa1psSFQ0MVQ1eDBRMWNMazdMdTQ4bXJCR0dpSUJ3LzFTZGN6?=
 =?utf-8?B?NjdQOVFzaWdDVXlKeWxiVlo1U2JnZWRJNDQ1RnRBZ0lxQ1kySXZqQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c1ddc-fe68-46c1-ac0f-08df4b8691dc
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:29:05.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HR161l1pYoTSecOjMuisA0SdCI9JzDs9s7vVzqG9/+2OTY2aQCsXqUiaUVYdkP83pH/KVi8envDVoAHZ7J8Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992186
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 06:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25079

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=11&day=26&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/11/cip.2026-11-19-12.01.log.html

* Action items
   - feedback on / additions to https://lore.kernel.org/cip-dev/av7hL4LCGQKBZa52@duo.ucw.cz [all]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - additional contracted support next year (update)

Jan

[*]
Date the data is created: Thu Nov 26 06:28:49 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip116
  latest version release date: Tue Nov 17 02:52:16 PM UTC 2026
  limit date: Thu Dec 17 02:52:16 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip137
  latest version release date: Fri Nov 13 03:27:41 PM UTC 2026
  limit date: Sun Dec 13 03:27:41 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip137-rt51
  latest version release date: Mon Nov 16 11:18:01 AM UTC 2026
  limit date: Fri Jan 15 11:18:01 AM UTC 2027
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.272-cip79
  latest version release date: Tue Nov  3 09:48:41 AM UTC 2026
  limit date: Thu Dec  3 09:48:41 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.272-cip79-rt35
  latest version release date: Wed Nov  4 02:13:46 PM UTC 2026
  limit date: Sun Jan  3 02:13:46 PM UTC 2027
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.190-cip62
  latest version release date: Mon Nov  2 08:01:07 PM UTC 2026
  limit date: Wed Dec  2 08:01:07 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.189-cip61-rt32
  latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
  limit date: Mon Dec 14 09:34:39 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.118-cip36
  latest version release date: Thu Nov 19 10:57:54 AM UTC 2026
  limit date: Fri Dec  4 10:57:54 AM UTC 2026
  Status: On track
