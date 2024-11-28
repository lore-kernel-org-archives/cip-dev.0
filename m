Return-Path: <christoph.steiger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44BD69100
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 11:49:47 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.41])
 by mx.groups.io with SMTP id smtpd.web10.92490.1732794584142556530
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Nov 2024 03:49:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oIKm530g;
 spf=pass (domain: siemens.com, ip: 40.107.249.41, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX2NwCpotwlF5tU7mMtMP/G33vrmEe9QcfgTdVmSaETjgKx6tAxCvDWw1iNu+n+bn86qGxuTWt5aG+9awcSlMeFMck4PscBG73y5UqILgExMEFgIwgOJoB98YaWYUceNUd1e7doc5MxInluKJDYh+ARsduZkg5/9m3xzCNGDEDMzPRH0QExz9xyXVoHs/ns1sql5fq+kHBt/lrT3pxXlZaj3wmB+ldNBTgXjJeQon6eqDszYBagpE8EMs+VrPM94dk51W3wnlCLiKJpFAZBKZzt1cq5b7/bxZXMVdjn533pU9GIsP/gMyfuP5RSt6mWhWLBdXhqVuJ9rBJpgyS2cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00CrBT4Si9BmwFxAT5ickjO8rp6Mt7yT7jwHSNs5PzY=;
 b=vgBcs898hCA/VV7zZFKjFN3gDFidFjYGvi4bSfAB+pz5IJTBhTJ4M3M+9Ki9vBkpGBtXbhK/Kj+3+btzLFMcpM7kfHtwqcOukWoIim28iAdXGmEB9ZllvEpQ3026MgR9AoR+PQoEBdkaCnwv33z1nS2aXdmkGZs/VABfEJsZhoBlFS4AkAp0kwyxelW+2sdk+SInOw/mZoJJ7int2/DlrNniQIGdI2KrqI1fNasCes/ehoovWNvkH4HA0KJBl9n/118T7EVeDrZ9nHT9Yx7GRmEpTZUPORVehgnZaPkar+Vq60tqhJ1tUniMVihVFqDZeUYGbnFRrdiYGz2j5cyQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00CrBT4Si9BmwFxAT5ickjO8rp6Mt7yT7jwHSNs5PzY=;
 b=oIKm530gZMfKR9lBsnP5t9R4ZGwtvpmAR8TYcp/WpVzYzECk13wZmIiBwSjEWei2zQOwwO4aK8qSyKt6FF3ohH1ZL2Ev+ODbBr9an8X9zHSP8L5gbCEc5k6REki5cbx586KSVvJAylr87fBTXUyO49DadjXfj16CispCWc1PiCEZA1hcLoOcg8dyZM+MiNCxzfPOUl4YmmnhywG3MeZ9eQp8yySfLt+61FwOTnf6fpKSv0I5tZG2pp+BWAWfzsXyxk6ss4XNWFlwb7lHLAsGitcVw+CKbeeHBpyMfrPOVsVrT05UDJSGQByRK0ElAzjo1K3giTCRxzC57p4gkHiwPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5)
 by AS8PR10MB6842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.4; Thu, 28 Nov
 2024 11:49:40 +0000
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306]) by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306%3]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:49:40 +0000
Message-ID: <dcebb010-9055-4b11-bd9d-4efba35c7fe9@siemens.com>
Date: Thu, 28 Nov 2024 12:49:39 +0100
User-Agent: Mozilla Thunderbird
To: cip-dev@lists.cip-project.org
Subject: Weekly CVE triage report
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:61c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7136:EE_|AS8PR10MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ab0cc2-1710-429f-4774-08dd0fa2be06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S2xwNHc5WHkwMm9aVHBXaGx1bFM1cnVPRCtZczJnSEI0dmtjUk5UeGJWUWQ2?=
 =?utf-8?B?VnFEeWV3VU5PM0J1NnZBUHRWTGlvRDRlR0RLZmZ0RTZGVzZlSjNicDJTNXV4?=
 =?utf-8?B?OEs1SUxkWGp5WmxEWm55VkZQSWJ6b2pDWWFIeURwY3lNWDJ0L0o5Y0FrcVhW?=
 =?utf-8?B?cG0xcXNTWkQ1bXJlSFB2elltV2RQajg3cVVQNGJGMEtoS1RIME9vekNjekdT?=
 =?utf-8?B?RUs0K3F2aWV4K3NNSDVvVWxPT0VMMlNDZ2xueDI3Y29zWnphbEQySU5sTkNQ?=
 =?utf-8?B?RWhoUVFxekFIZVN1WVFITzhrUEltNnJFcmZQWUg1TTJscjg2aVhtb3lSYTk0?=
 =?utf-8?B?b0JkUmZJRTI1S0xDVjVNejhpeFc2T3N3eTBnY1NZUk9wNW1Yc3hGbVpESHp5?=
 =?utf-8?B?djBHd0JZSVJkN1ErVnI4aHBWdllVdWdFeEJBYUdiMGxPWGtZUjR4MnJkQ0lF?=
 =?utf-8?B?RlUwZG9DalhnYnFvREpPL1VoTzZYT1M2YUZMaGZxNjhxZlBpMDZ5ZnZEUnIv?=
 =?utf-8?B?VjlSMC9TQlMxNURMT1ZkdmVYbnkyVEpnM2JwM01lekNTa2s5MnBRbTZJMTI1?=
 =?utf-8?B?V0VzL2RNKzBEVXlaby83YmRoNEVleEU1MDJQV3ROZGl4OUMyUVd1cm5jMDFD?=
 =?utf-8?B?WEs1L1Q5bzVTY2IrRmxDbnViWmpXcDJ0TmwwdUZRdXhwdjg1TDFkOVE4NUJq?=
 =?utf-8?B?UHliQ09qRExTSUVibWJ3RnJHOXF2SE1Bc2FMMWcyYU5hWlZ2MDdpWlVIdzl3?=
 =?utf-8?B?U3drV2lUUUhmWHlJNXp3RlJKTmIvSExXTkJTUG1UWEVHUVpSdmRRT3VsSDJX?=
 =?utf-8?B?Yk1KVWJDa2doaFFBbDd2cGV1WStjb014WStIRURMN0JzVU9MY2hscVBZbEN0?=
 =?utf-8?B?dGhLWUdoWmdoRnlnTG1Oc1p6U24rcVl2UCtBa1V4Mnc0SEFNWjBLNU8rN2c4?=
 =?utf-8?B?UDlEeFZHWjUxaGpXdGtmdkVIM2Y1dW5ZejlRNkRaeDgweURKT1NBZ2szaVdE?=
 =?utf-8?B?SE4vVFI3SE9HNjFWN0tvdExva0IwQUpxb0E0UDlIUzQvWEVZQ1RaNG4xdTQ3?=
 =?utf-8?B?MzlsbHppWFNrUnVHQllRMjJzWG8zdVpjWWpxb09EeEFMcXhNSEV6Tyt5Z05Y?=
 =?utf-8?B?SFdGQ1gvdW4yM1ZIZllaSTBNTlNmSTJMRjZmMzhpVWNxbjVKd0RLaGswQlR5?=
 =?utf-8?B?aml0N2hQTlJMY28xcE5GbnE4S1MzNTVjUUs1ZldyRHRpWHdzcWFDKy9rbUo4?=
 =?utf-8?B?U3ErUXREU3N5RXBCV0V2ZWZVQXBRYUlaaW9TVjgrYXVaVDUvTm5ybjF6bm9j?=
 =?utf-8?B?dkdGRXRzUDhlaGVldW1EWXBMNHRsd0lNQThlZUt5ejVyQks0OTQ5K2RvbnQv?=
 =?utf-8?B?MHZVYW1FdFJMSDZkc0VaNHZuV1lKR0FSZVpNMjhzb0ZFdm14MWNSbXpEZkFN?=
 =?utf-8?B?ZlhTZUY1TStHTFBiUmdhYjZmUlZlZUhEK0dQNTh5cG9aUjRXQXpvLzhUbXNN?=
 =?utf-8?B?T2hrWG9ZaUxZa1Z0SHVpQXRXRjgxMkpPVzAxTUNjM3g3cHp1NStkTmZNNm5X?=
 =?utf-8?B?cWlqRDdET2R5RlFPT09vaEIvbkVDUlJVVy9uZnFZaE50UTZjK05pVkI0WXNq?=
 =?utf-8?B?eUFxeDYrbzdVK0lPNGFlNjd2a0MxQXdxL29YYkwyZjNydndOUXNTVFF3L3Fa?=
 =?utf-8?B?MERPZHNHVTFnZDFDSk10cUZNTkp0aHV5TTd0OFJMVnZieDZHOHA3cmMyb2dl?=
 =?utf-8?B?OFpxbVVaUXdsRDdVdEFiUGJZUGZTb2RpODFLYVRvd3lCN1RuQ3R3ZWdMTmZy?=
 =?utf-8?B?T203T0lvaFkvUjhGbC93QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU1mWTdIS0J2TXF3a2E3QVRlK2hmbGVBam5yeDMyRTBEaEVOMnlKeHp4MUFP?=
 =?utf-8?B?c1pvTEtxTVRoQUlLcVg5OVB5K0syT2EybHBFNGVSektDUEx2TW5rV1ZVZHpu?=
 =?utf-8?B?V21BR05zeWlKWTkrb2tuMTFGa1FJTWx6cXAzN24xMlZVTlJNRzlSSjhRenlC?=
 =?utf-8?B?TXU4R2VMQWtYRnplUXJuV3ZUN1hkd0N0eDRlNG9KN3JzaThSbXRRdnk0NVZM?=
 =?utf-8?B?TjhYZkM4cmF5MGhManZhK21lWGxYOWkzWWFBY08wUkJVWXh4WkZOYUxKWTAy?=
 =?utf-8?B?aXQ2Q3BUdklBMzNOU1p1TXFNSkhWQnJIM3Y0bU9KbG9HR2RWU2oraHhzSFZN?=
 =?utf-8?B?TE1LOXF5amdDbklLMGJIVk5leFJFME1KNmZYZ044ZUpmVmtBRjd2UDNPWFo3?=
 =?utf-8?B?WkUrZ3R3V3E2T2NUS2JtSUo3OVR4YnBmMEEyK3d3VDBzdkVvZzQrY3lMUjk1?=
 =?utf-8?B?VXVOejQwYU56ZjZZeUlWQ3YwbTh1ekhOaFB1U29YbkFQNlpnL1dyOGJRZ2h4?=
 =?utf-8?B?V2JNRWhtcDNNSGcrM0Q2MzlJRm5mWWZ3dE8ybUQ1elBZdFU0RTNTWTNmcFdL?=
 =?utf-8?B?dXdUckp0d3FCQmsyd203bDhKMUhqUERPL21EZFFDUEN3TVVVbnk1YlBYUkFt?=
 =?utf-8?B?RTlxbU5OVkp3WURTcGloQkhnY2VUa2xScmpjSnJQVUsydy9lMGxWczR4Q1Nw?=
 =?utf-8?B?Rmh5Z3Z1VXpoR1Jad3cwU3pVb1RUMEJGMzhLRkNuMG5OdVhqV2x3bDBhdnlz?=
 =?utf-8?B?QUFzWmRPOFdaeWZ5bTBlWXo4M0tWSWpqTW5TZ3o0TnJic25QSVVMME9tL1hm?=
 =?utf-8?B?THJvWWw1VGh5ZUJreHcxUkIzQUtCczNKR0RCWTZDRzcvVDk2TFU3d1NDMWRm?=
 =?utf-8?B?YUl5bHVCaExlWnV2Zjh2c2srcWtXNGJmU3d0b0d6Y3loN0daMGhZdklHam5L?=
 =?utf-8?B?dWJtektRaGhUaEwwcmI0L1RJTWRRZ29KQ1hJdHVZMCtCZTcyUnpnc2M0eHE5?=
 =?utf-8?B?MzNUNUJZU0NWckd6ZmxkVUhGTE8xd2krRXR4MzBlWVZORU5Eb2VEOWZHZWFt?=
 =?utf-8?B?NlRJMFBWTnBLQ2RseE5tRW5iWXkvc1BWMysxS0Izc1orV1ExVUZjcW0xcXQw?=
 =?utf-8?B?SERrQ3VEdjJnTEkyWFI2SVdiMm15M01GdG44MDVxZCtHYUVtUk53UC9ZZzVl?=
 =?utf-8?B?SFJ2Wks3bWp5R0VNVjYzWHU3ZUx5bXlialY2TUp5WDdlaUxXMS95Wlh6Ukps?=
 =?utf-8?B?K0NoTlN5WTFiMk15VWpkcE45QVJGZE1oay9NWHo2NGk2YnZsbGJ3WkRxamVt?=
 =?utf-8?B?amQyeHBvSE0zTmNIZTFMSC84SE9sUXdXT2tZaGltMkdtVTlEc3haS3pvMkdv?=
 =?utf-8?B?OFJRNkxTaU5oMlduaWZEZXRzcEk2QmhlQ0V6SVVTU2R3SDdodVo4SU84UmRJ?=
 =?utf-8?B?TTY5U1p2Yys3a042WlhzRUNDNjZiMUEzT2lObUc0cU4yc3JRTTNHaHV4S3dQ?=
 =?utf-8?B?RUhtUmg2eGo4Z3N4SmNKd0YxVGluNmJmd3dSR3FUZ0xCZmw1YVpCaTU1dE1D?=
 =?utf-8?B?U2NBQXlRZDN4YnREMS83YllwdEZRUTJvMEhqWjhoeEtlaXhGVCtMUzMvaGJB?=
 =?utf-8?B?SkpvalZreWRZc1psSjNvbU9EVU11aDV1dU9xck5yUE5MNkxnTHpCaGR0ejJk?=
 =?utf-8?B?eVBnZlhPeXl4bm5SNXlrZ2FTTWF0b3l1SGIyd2c0NHgwMmE0NmVnQngxRGMw?=
 =?utf-8?B?ZUw1R3FPK2U5TnVWK1hKbTNzNWFaMG5mb3doZkpWT2czMThLUUx3UkRDd3c1?=
 =?utf-8?B?TjRQVVMwWDVKcnhtbmJaU3VzTDd4VVRtdVJzQS9lZ1oxeVJGMW5LK0JSa2Mv?=
 =?utf-8?B?V2hZOFBhT0JxWXdqdFJTYlVEM1QrS1p2d0wrYUYzVEYyRGJGZ0Z6YUNQekth?=
 =?utf-8?B?eDRXWGN6R0x6WFl3NTNvVkRDejBUclUwb1RXRTRvc05LRnBxbVZ3SVhRVGdK?=
 =?utf-8?B?UDEyRnN3d3JONngwZHp0a25ybEo0VnorZ240UU1qVlVua00rTHVJTEwwSHpm?=
 =?utf-8?B?SGZmVFRFYmxCUGt6U3hUVVBBdDE3VnZXcGdkby9IZ0NJYm80RDZvUFQxRHVj?=
 =?utf-8?B?MHpBM0NvYlJOTStRb3NDeGhQbk1FMGN6WHNVUzluUGNLZm1sQlJybGFaN2d1?=
 =?utf-8?Q?hhhgKAZF+AqoIxbafOeo+jI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ab0cc2-1710-429f-4774-08dd0fa2be06
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:49:40.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laZE44wgMBOA3t7Ixx78ag+SJ4+K/jQHphpECbQXmYd4LbSiyqOomGLyHNtt9VcCWPJ6KUq7fkr3Wy68t5PjjCktTy8depKJjfJNQcrhZyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Nov 2024 11:49:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17298

Hi everyone!

Here are the weekly CVE triage results.
18 out of 32 CVEs need further manual review:

CVE-2023-52812: drm/amd: check num of link levels when update pcie param
affected versions: v6.1.118-cip32

CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset is 
invalid
affected versions: v6.1.118-cip32

CVE-2024-35964: Bluetooth: ISO: Fix not validating setsockopt user input
affected versions: v6.1.118-cip32

CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring 
'power' and 'submit_queues'
affected versions: v5.10.229-cip54 v6.1.118-cip32

CVE-2024-36915: nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
affected versions: v5.10.229-cip54 v6.1.118-cip32

CVE-2024-36923: fs/9p: fix uninitialized values during inode evict
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54 
v6.1.118-cip32

CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service
affected versions: v4.19.323-cip114 v5.10.229-cip54 v6.1.118-cip32

CVE-2024-49974: NFSD: Limit the number of concurrent async COPY operations
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54 
v6.1.118-cip32

CVE-2024-50242: fs/ntfs3: Additional check in ntfs_file_release
affected versions: v6.1.118-cip32

CVE-2024-53090: afs: Fix lock recursion
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54 
v6.1.118-cip32

CVE-2024-53091: bpf: Add sk_is_inet and IS_ICSK check in 
tls_sw_has_ctx_tx/rx
affected versions: v6.1.118-cip32

CVE-2024-53093: nvme-multipath: defer partition scanning
affected versions: v4.19.323-cip114 v5.10.229-cip54

CVE-2024-53094: RDMA/siw: Add sendpage_ok() check to disable 
MSG_SPLICE_PAGES
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54 
v6.1.118-cip32

CVE-2024-53095: smb: client: Fix use-after-free of network namespace.
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54 
v6.1.118-cip32

CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour
affected versions: v5.10.229-cip54 v6.1.118-cip32

CVE-2024-53097: mm: krealloc: Fix MTE false alarm in __do_krealloc
affected versions: v5.10.229-cip54

CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fdinfo()
affected versions: v5.10.229-cip54 v6.1.118-cip32

CVE-2024-53102: nvme: make keep-alive synchronous operation
affected versions: v4.4.302-cip93 v4.19.323-cip114 v5.10.229-cip54

Kind regards
-- 
Christoph Steiger
Siemens AG, Technology
Linux Expert Center


