Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BBCA0ECF
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 10:08:46 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.67])
 by mx.groups.io with SMTP id smtpd.web10.21408.1694513320130294001
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 03:08:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jeSBDPx4;
 spf=pass (domain: siemens.com, ip: 40.107.6.67, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZUt47p0QrfKlepnu+t6R92dxHVFkLVVnHBkT0jJYyh9jLFOXusXW17/c2r6IGRZIXpJkt1dre/oGCx/Co1/dkdVD+xDJSVIz+zhCrz6m5m7U5JzQzJznbofOFlPzCKAPKqbmWGNyYu8qY93bjjUo6cggJ1anzIX1JT3fiIE/G5iWylTKCdwGdBX6Iu2hhOrunpVN2QVD0z+jsSKsQ89BDIdUC6DS38Y8f60WTpucZXpUKWgYVpionJ70dJfEJqJoxyBVTybVAzrM9mVbPbLizfB9X0VRoil0x5/I4ifvX0rJUgDJQ6McwVOV2TGXoO0jWkcX2yx0FM9EiDjnPE91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L787lm2Pc6Yj+Lqi4npWbus4WtWerBV6QLBVGZMU0Po=;
 b=f2ZRRopuhvhVK2a967eyeu3VxkE8KwxvODG8FbemjuYMqlXBswZVCzMKL7sMMwR9sVbPgemkPXzZ+w9G9gpMHLqGKgNlSfZjO85xr0fyPVbeY2zyAU4zz9sMuyAEzTGU/rXi7OCojYxCLiqKnWq21P4RiKIPsH0zTewDUcfkNF5W5ST9nYpfQYKP8MsV46vrdjpAhtO1wvFhTh5ptv4RaUzCnLvttgbWI5nEwloqJql/Wo3ZcrnxzNQIe85f9zC3/TUgubBZ3e1AO9OX6Wo6n7Mi4Dxft+iwtApZiJixt9LFsikq8KmyG2wxOYnJF5biHIHR61Y6THBBDxBWBzys/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L787lm2Pc6Yj+Lqi4npWbus4WtWerBV6QLBVGZMU0Po=;
 b=jeSBDPx4ZHB2I2w2sjsLiclP4f3J65u9KCOXsqyu+BOcxGHPRy8dWuO9a4hil0mOIoPyrLPXlKXDrLJELW8JxjNl0JojKEUSC1vGdyXzYhcBzFYmFrHWsrPnVLudmKiusansTReXMS9VjPjcaLcRSAVU4gDT11ZPiI86Ki6gRqagZJNy9VEsqXfeXKKUxjLwpNJaMH8vCtOEHjNSCRI4uWeS9q6MzY/D/cV+vgXOCy9EEb9TB6KgS/o6Cm39XcIxNpkzZlbR6Sdjufks/DXMQ+asRydIYemAbN6WV8UJvZ7gcvDr8eDcB8Wxg8J2ld68G4pNyiS96m/nIvo49+LUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5324.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 10:08:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:08:36 +0000
Message-ID: <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
Date: Tue, 12 Sep 2023 12:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
 <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:610:4e::37) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 237937c8-e8a8-4547-6efd-08dbb3783a58
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rHwHRzNOX8TlRa3jIXYs3knPrwepUwXVjYz0KXcBYg5Uh9TcJIfVaalGSisS2fLwDh5dr27ygcN3arUejRA/Sx2YNl2QfOqXvdRmBiukp+es/V7ZpY8lEzjlU//SihwLVkAi8QLQGuKGF+tUPtn2WNI3OHi8rKDoVqtX9QLbmyW1YZIoAQUD8mWhBy22QFGp2+RnPAmSmrHKklIJ3B1wMe6Gy2YfvGVPvZ9CCRdBKbLd6SOPcv7dpxT6jg00+S0Hj6KWUWJCi2axqSjdW8c62A5e9z2miX80lBkDIw/5Mt47gT2GE7YtMncTw5ACJwOqlh0z+XwI9xlr+HZo1E1YR4Hxwd4kDMiBoDtzEvT2APtMJuZSe6yYt3k2Px0Vdk/w8d1V+mV9+TGwBIiCd1phCcpyJVsXFEdr24njFqZDGyUyZHRHMRrgciriWhxyMfSCMELcpSHpKCuW5kYrnShRJQyxeAnOlwii+rZvIe08C6Zs0SERpnYAvcmuA0TLbMuZ7WH8DEEMD90HTfD+UPpS93okZpjLQ8vRV8dWE/uVJhVj7U1u9Cy87jVb6rXNDqYCb15G9AhClooqo3705BhzQ4oRvp8buSnznbb/VnHWl2k16MXdpK8Rs+plH2mGmpUcWQmNw2KciU6zEHHwLlFkeA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(1800799009)(451199024)(186009)(8676002)(316002)(41300700001)(5660300002)(8936002)(26005)(2616005)(31696002)(82960400001)(86362001)(83380400001)(6636002)(36756003)(2906002)(31686004)(38100700002)(6666004)(6512007)(66946007)(6486002)(6506007)(478600001)(66476007)(66556008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?citWWGpYcWUvRGVJY1FCKzByQjBiWi8zM0oxV2xHdTRudERWbHFOSjZkT0do?=
 =?utf-8?B?dmZnNXJDcHdCOC8wZ0VPYWc1dHU0SEMyekRTeTV5Y3I1M0g0eXJocmtieDhq?=
 =?utf-8?B?YkZKWXhZbVVvbHpkQmQra3Q1UEx0SU43VTUrVWZyQ1cwUGJ4bTNhMVIwbzdO?=
 =?utf-8?B?eStiZndrUTFPTkxhWVZzUjVxUnNqV1hyK1NwQm5WNzlJY0ZQaGFsdEdyWHhj?=
 =?utf-8?B?Tk9DZ1p4SUxDc0ZRamZBR3BSVGxzWU9EaTZ0TjRVSUdsdEF5c2pmZlh3eFN2?=
 =?utf-8?B?NTJoeHNLYzkvUERMWE1IRStubCtGcExUYlhLajRBUmNXUFk1dkVqS2p0QWU0?=
 =?utf-8?B?MWxkNXVVVzRFbzlSNWNFK05iNW5aYVI1L2RGVjI2UmNFQ0xwTXFrMTgraHUr?=
 =?utf-8?B?OENQRDkxc0hsVmJ1R0VzSDZnWFNrZWREU3pySU4rQ1NaMm1ZM0YrMkVLRFda?=
 =?utf-8?B?Tll5aHo1V1N2QjB1SjJyQ3pYMjF2K2Z0b2xZWURnSWxBc2dvbUc2ZmxkeUJB?=
 =?utf-8?B?K0lsMnVETitnaGRKOFhPK3pVRkNKUWU1ZzFVZUhhTWtKS3M4VWwzcUQ5NkNY?=
 =?utf-8?B?YzBuQmpiMStJV05hdCs1RWVtelJ4TjRHeDQxWHBPN2Q0MjdmOG9RYmU0ZmQv?=
 =?utf-8?B?ZTVWNnhmcEJIMkhKaThGSHNJZFh5QVhKZG5Rc3pHSzNldmk0UWRSdXNTWGJx?=
 =?utf-8?B?ZWJqWnJWZmZIZTk1bzdtdmJvTExlTXNlaUR5Z0xQemJXMElRRXBoOWk1bFhM?=
 =?utf-8?B?dkE5WEVES2F4emxQU2FoRlVlNjU0QUtEK3JnZkdXRE9wblV6UGhnRnFnY1dw?=
 =?utf-8?B?OTNPcW1FRmhGVFE2V2xNWmx3RVpYU094YStiVktwQmxKeDdHTm5adGxibWFN?=
 =?utf-8?B?WjlSRFZvOEpXSGRIR0k1Vkt5bFliNjNhb1ZtdkJoZGUzeUtPd015anJsUllT?=
 =?utf-8?B?Q2o5bElaNDlmbzltL2sveWhWT2MwYUdlU1Q0SkhUVmFxSDBUdEp0WXRKSE9S?=
 =?utf-8?B?V0VkKzZEcnd2VWNiby9QcDZlVjYrRnBmUXFpUWxPdzkvVHJzeG1rRWZjNURr?=
 =?utf-8?B?VW1aMjBqb2dBRzd3NmhKZEVzOWVvWHcxeHhDaTdyTjNBOWtHYjZaUnZJS1Fq?=
 =?utf-8?B?OW9OeSt1YTNmdVFOaTJaN2VpU3BmRkpkQXVyTlhaTkdMVnM3SFFPckdoMDl6?=
 =?utf-8?B?c3F3SVQwb1FpTGlTeE9naXVvTlErTEVsODA2b0FreGRrNWxwdS8yYXdDRXdP?=
 =?utf-8?B?Q3kxOGV3Z3ZHRER0WlhtTEJtQy9Ra3VCWHZ6VFFOenYydkEvOWgwMUo5cW5C?=
 =?utf-8?B?TFNKQS9SaGNtWnlDTThBaE1NVFRxMStVM0d6RlhnUHNFaXdwYklFNk1kREp3?=
 =?utf-8?B?dWpmQjdpemN0VVhTQ0RNWUZrMHZrVEZTcFdYcFhFd09xUVowbEFVK1lBWnNs?=
 =?utf-8?B?MGNSNjhGamZzNkc1elRzOWRYZmhwSEpGdkF4ZTVKWWVmd0lJc2VVUVpUZVQ2?=
 =?utf-8?B?MVVRcitJZHIwb2p2TmtQUTI2emZhSXNpRENPNTlmLzhsaGFuNm9QbXhmeTlQ?=
 =?utf-8?B?bDltc1ppOExSb293eVhaeXBvK2V4Y0FBOCt6OWRuQmdCcHBXRVBRR25iV2NM?=
 =?utf-8?B?dXFZQkMvQkIyMkp6cUlLc3BoT3BqU2lNUGk1VnZDdFhSWlIwVCs5M1JPcTdl?=
 =?utf-8?B?c0ZqVUtUZEc4MVptblFCUEZwRThib2NiSFdhdnJkZlpnRnBtRXd5ZURNZGRN?=
 =?utf-8?B?RENFbU4xUVdvUmsxNFZRdDY2QkEyNzdob1loV0ZKeUVpYkxPbGJCYVYrTWwy?=
 =?utf-8?B?SjdXclBpSnNybWllczBBdTFESi93VnkyMTNPMUdINGIzeXlmYVlXUWpja2N5?=
 =?utf-8?B?eVpUdUtFek42LzJTVzFiK3QrdUtxL3A2UHc3eWE1bU40bmJtOVhDWUU3KzV3?=
 =?utf-8?B?T0owTjJyUmtub3FxNDFuMlN5Y2FhYUdMUmFXWE11UHlXMlBMUFJJdGdVVE95?=
 =?utf-8?B?bjMyTXRqRERXS3JFNmVGYkp5cFo1NmVSYkY5REZYTlRBWUFhSkE0TEhPMGll?=
 =?utf-8?B?SWZobGV0T3lCMlBsVzVoekNwYmNjM1QrNm1aTWpiVG1iZ2ZCdjhCeHpWakxB?=
 =?utf-8?B?MHdwOGUzUXhOTnc2SHExc1Bsb2JPS0NMcVplZUtoR25iWkNaWUZ0K0lKeTZB?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237937c8-e8a8-4547-6efd-08dbb3783a58
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:08:36.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceid0UQ9Yf4LGqCdiH9yfPqg4tBKYLmC9+T6qNudgTxvqaun8UUT6E54KgzPpGKsvX5Vko5IYxhrM0HF1wdsyzu2ghMjtNnWd3VWk0W0a74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5324
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 10:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13058



On 8/28/23 08:47, Jan Kiszka wrote:
> On 23.08.23 15:28, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Disable the timestamp of the do_install() task to
>> re-execute when ever a dependency on do_install
>> is executed.
>>
>> Without this change the sstate needs to be clean for
>> every rebuild.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb         | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> index 3fc63ed..7435649 100644
>> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> @@ -40,6 +40,9 @@ do_install[cleandirs] += " \
>>       ${D}/usr/share/initramfs-tools/scripts/local-top \
>>       ${D}/usr/share/initramfs-tools/conf-hooks.d"
>>   
>> +# Ensure VERITY_ENV_FILE is updated also when rebuilding initramfs-verity-hook
>> +do_install[nostamp] = "1"
>> +
>>   do_install() {
>>       # Insert the veritysetup commandline into the script
>>       if [ -f "${VERITY_ENV_FILE}" ]; then
> 
> No other dpkg-raw packages require this, do they? What makes initramfs
> packages special here? And what about those in isar upstream?
>

This is necessary for the initramfs package which contain the 
checksum/uuid from the root file system build.
This ensure that the checksum/uuid is refreshed.

It fixes the problem that an rebuild of a verity image leads to a broken 
boot after the build.

I will send a v2 to clarify.

Quirin

