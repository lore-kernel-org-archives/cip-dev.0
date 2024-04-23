Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885CC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 09:57:01 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web11.14605.1713866213065079507
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 02:56:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xRsmchjp;
 spf=pass (domain: siemens.com, ip: 40.107.6.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvY6LX7t3RCBZoKTeJOFiT4MaVL69przt16e7jqFCOMCinjxnxGBF9EVSVwVkCDjzBmVamE0h8L/SIGJgndbiYZwY0rsETCyQGfry7X/12IcpgnLrvkznq1ODmPPkhzF4XwLsCWPJxevuKvD/nJuMWeJt57ZVnsEsWI/DOytSlzOyQuiq5hlxzJhUoz8V8WHutBEsQsPqnVc0g9BRsw0zNMtiOnd368hTW53hpMl4KLzvWWjflQa/tkyngc3GyamANhaq2EaTpIwBxSIIEf3wYmC0EiQKBU+7wGhXmN63Fi3LC/m2IBmqQJ5d31f+fuplGXlcKGISvhlvyaL6hB5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0PtSZaJPNkK1HigjZoufWigTIe4v0CvCwnK55vJAeg=;
 b=Rfgy3ahf8WeZlaHYbjQ1xrXWmiIMDFU9iEdAqga0mnDC04meUCTwFtQRv0DUndAtOR1wN2hhxesK8iWKT7WUm5j4WhFz5YGAcbE19tgicu3/W/XfO3K/NmkP7cVHsag1L7FAw6nTBDH+xIrrhYvF3zxEVo3fyzSMyioi9PNXITI+7Zuq6ePg0/YrcxteFWE4yZ/S1yakj8NoQSiIGok87ydLUS4oOAGqRtASWCm4yaPX+wfxSiWLkS5TjLQTnPzNFb1igAnM0f/UKrSfXfJIhHZDP8o4Ct+Kiyu77FrsivcuopP3s+NcJUB0wzPt3uoXXkqYoKJhA6opweFpO3m2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0PtSZaJPNkK1HigjZoufWigTIe4v0CvCwnK55vJAeg=;
 b=xRsmchjpHyWI/BaFGYS5i7rHV/KpJt0yLRQrrcT+m5yffyUqauV4r7LTAw8byqqrRU0jNV7VxQkwIQ1f7l0q38OcSsF/w9U5VUcPZ0FiYOcDTBCWQc7fozIT7wO4smUEK4wx+OAkF123VLRhb2lSV8i2KPdIF5m016u1cIDHN+Si1C0Vpw8ETMOmx6zVlT6hB/EaYj+lQCcuLSQmh+3cTeA/Ju52MnqGrPvgPcQaugljLFi7te1lTsIymipi674k1II8KAHyz2ajbJnwqN56v6NDAe4p3x5sad2DXGXuD1xZvD5DFuHc4EuC5ViCrHFnYXZBZHFiUSU4bkRvO3D1eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU2PR10MB7678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:498::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:56:49 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Tue, 23 Apr 2024
 09:56:49 +0000
Message-ID: <a48a876c-1570-4281-bf46-9f6bd423c8ba@siemens.com>
Date: Tue, 23 Apr 2024 11:56:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 7/7] README: Add rootfs
 encryption
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "johnxw@amazon.com" <johnxw@amazon.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
 <20240422141120.577573-8-Quirin.Gylstorff@siemens.com>
 <b3c6d71a45dcb090c619413476ed1d206091cb9f.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <b3c6d71a45dcb090c619413476ed1d206091cb9f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU2PR10MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eff63c3-a249-487e-625f-08dc637bb1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXg2bGFIc1RmTjlIR003ais1ZC9ZbitVb2NnWVRveWlGVG9tT0hXWnNVRDA4?=
 =?utf-8?B?dnIwMU9tQ0htT0hqdW4zeTcxbWE5WXJWYk42ekIyaVFRUEpGbUJPdUlLcEl2?=
 =?utf-8?B?T3E1N1BhWmg1NXU3cHdGQVVieVlmaWlyQytrWlQwTi9zQnhkRVBqVTlVVlg2?=
 =?utf-8?B?QWxlYnN4ZHNkWkwzcC94TGRVT3JFd0U5U05YcGZQTmRXQ1RaZmw0NnNneXlH?=
 =?utf-8?B?dXJCSFc0aU5RdVA0VkFpTTNaeUNCdmo3T2VuT21SM0pxMi9sU0RGWkV1c2pZ?=
 =?utf-8?B?dFJMSENWVk5jRFRiVTV4bHk4SGxQUDdKQlA5dkZHWTh4WUs3Tk9xemtMNWl4?=
 =?utf-8?B?ZUNvNENtWjJUOTdWNXpRVWlGbHJCbXhTQ0NBSGJ4NnRuMjZKcTVST3lxTlhB?=
 =?utf-8?B?dXliL0h3RVZIb2xQNko3Rmo1TUEzZDZlOGpsRmNuWFN5cGF3bDJNcGdXdVFv?=
 =?utf-8?B?ZXNjdmU1K3dSd1hwTHpCR0p2NHgwUFRpcjg5U2Z2R3IrZWM1R3lpR0pZNThT?=
 =?utf-8?B?YSs2MjlXQjdIU2lLazRBS1V4cERQakprZ0lhKzNYY3U5a0pkSmwrYzVvTHE1?=
 =?utf-8?B?ZDJVQzBOTnpZbFRUeHhPL3I4alovcWhNUnpmOVFad09iOGxyU1piMlZPbUYr?=
 =?utf-8?B?TzNQZEwxbllidU5wQkRYcTFCK0NMeXdyL1lyVmhMUmpIN21VVEI5VzZYU1Jh?=
 =?utf-8?B?MVhnRUpTeVdiL3NvdllUeHd5bjlqR1dMYVZUb2dySnhvQm9jVEM5clgvSkdE?=
 =?utf-8?B?NVZvbDRUeUY0Yk0rdjNHamZwNXgwV0Zob3pPbXUrSDRoMFErNUoxaVFiNjFz?=
 =?utf-8?B?d0sxYjQwd3NCVk5zbkthK2xyRGlORGt1MVZIS2JvRXB2N0xrZWs1MFpNMjJy?=
 =?utf-8?B?S3VqcVhGMXZ6elVrUmd6RVBWeVFTWEVxa05CMkQwdjl0bDVmVVA4N0xZdkVW?=
 =?utf-8?B?c2M2cW9qdHdKbjIxTE9EOEpZWjRWQXlqbnNMSExVejlETmw0RGZycHJqVll2?=
 =?utf-8?B?R2RzcDNLYlZQQ01WK05XYnRtd2VnRnZBTFYzSlNDdGhndVBqdW9CWmZncGoz?=
 =?utf-8?B?MUtTV1owTjZDVmNhT3dseFRjcGl2Rkw4a05seVdLbmlNYlhNeXdmVURIOExS?=
 =?utf-8?B?NXdjd3YrMUJyc3JKbzhuRWo5NjMyYmUwL0NEOFlrZXdlNUt0dm9jTkl2VlRt?=
 =?utf-8?B?amErTWwxd2lPZVljek1nSjNsY0lhWG5vTU5temgyYUNHYnQ4SzNtQ1ErU203?=
 =?utf-8?B?RGZzdGlkWmUrVzZtdE1RMHEzT0pHRitKbmFFZER1NWlldjVLdzRQQnV3SGRs?=
 =?utf-8?B?T01uUFdGS0hvaGloalpyU3RBTnd4Z2phR2NLVWMvbDZQZmdNd3ZsQ295bzdj?=
 =?utf-8?B?dWpjM21WZyttdkZNdUdqdjNyUFN3RHhMaWpTTUpyNjc2dXg2NyszcVNGSWRO?=
 =?utf-8?B?NFltTHNBUVNsdm5rTTkydk5lcUpjNFg0MlZVMzRZeG5kalpQejRFdjc3b0pG?=
 =?utf-8?B?TnYxSG1ZeGZqb2xVb3h0Um1sZkU2MTdZK1Rpb0JXa0lyNXcwK1NEdGJid0lY?=
 =?utf-8?B?emllOXpMbUdPRmx0UjJ4ZnYyai9WQy9MeWRybDgxdDRKRUhVd2ZvOVBVTVpx?=
 =?utf-8?B?OStubnAxRTZ3V1UxWitwRjlKV0lXZmdON2VKbGx6ZE4vWVJtaVRNVXN6SXZm?=
 =?utf-8?B?aXB6amQxYXZtTFdQQTRlellvUm1tK0t0WWtCNitYWERON2pUVHpNU1VRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEs2cW03cDU3L3lsdjNpczEyNXh6ZlBSaTg4T2ZUQUUrblkxd1hMc1RWa2dn?=
 =?utf-8?B?Y3VybStmb3FMQmRmNWpDeEUzUEhUUUp5c3hVT0QzZ29Ka0lSL3gyZ2MyZ0tt?=
 =?utf-8?B?Q2ZpU0VWV1pmUTdZWXlPTkE2WXcrVFF2UUg4YkhlbEFZcGd6ZjJCblJWcVVN?=
 =?utf-8?B?Y0cvTWI5NklsaVRzSnZBNHFmeVBDaTllcWwwQlVwS1MrdlhJTHVyaGF5Tm5Q?=
 =?utf-8?B?UnRYTmNVNmxTaE9NRjRUWXEzYnVKVFI2WWoza2h2alRLQ1dna2RTcHNuN1FM?=
 =?utf-8?B?OXRPdVJWc2tQeHBYbmEzTGlOekpxSHcrZmxLR05VQWNRQ2kzR2libWFUSUpl?=
 =?utf-8?B?L3lBM01lTWFLZEN0a3hYQ3VudWM0WGR6aU13aWliemdzR1ZUYThhL01FL09i?=
 =?utf-8?B?VjVoemt6THBCTHl3Q1RIc2trSHI1SVJ2SkNHQm4yaHRkeUNOdThndmpsTVBS?=
 =?utf-8?B?WEhPNElmLzFjVnNIRkFDejBrRHBhVUhLRXN1bkpYOFdvdnFodGcwbFdLL2ky?=
 =?utf-8?B?ZE5uR00zVGsyS2UyT25KZk1DYTNrYXpyVU1wMEZvaUNUNk1xOWJPbUpobWE2?=
 =?utf-8?B?YlBqOUhsbURGdEtoSlF6UTZBMDQzOFdMeHAwUmVGSEkzUFdxcC9McUJuOUxX?=
 =?utf-8?B?RXNvVVRTMFZEWllaRlVhMmFVdWIzQXZFaDl2WnNHUDlmN1QwT2wyWHlLK0du?=
 =?utf-8?B?UGFabnNxQkVVcElDM1h2eTlhbVIxb0greld6UHRmMVFXaFZBQ3ZtQmZVUkxT?=
 =?utf-8?B?Z2ZkWTAzTzFFZGRwblpsczM2NmtVVjkrNW9mWjJWSS92WDJSZkRHallOdUlH?=
 =?utf-8?B?dXpyUTc1OFhvMnFJMnR3TFkwU0FTTllrNk5pVThSNVJ4LzZ5OHRDbVJyMDRR?=
 =?utf-8?B?Rmx2Vjk4cktEbGx2TFBmemVUMnN3bUlwTFlvSUNGN1plMjNmUU1ZM1dpNHlD?=
 =?utf-8?B?YVBwRDY4VDB0eFExYWFUOFBwM08weGg3UHRnM3pFaExWUC9Ld3FmenVvSlBI?=
 =?utf-8?B?Ull2Ykg0bDREZGdMVWk0V2w0ZFFoSVhqT1V3SmlDOVJ3c3lXQm51Z3VHNzJo?=
 =?utf-8?B?NERXN28vQSttUEViTlZMZE85NjkxS0tlZ0RUYmlBbkZ4eCtvMFFmRHl6YjQy?=
 =?utf-8?B?RGN0VEZNVlUyWlltYjY2MEFEWVpYNlFiTnN2dmlpZFNIN0RjclM4d3hHQy9T?=
 =?utf-8?B?RVBqa3dvcjRld3BoVlNkd0hMOU91dURyb3RlUEF1L29Mc05BZ3ZHVGtub1lr?=
 =?utf-8?B?K3h4aTllU3d3dnptVUZleWJsZHBiZk8yZVBvbFpsR2kvQndrblFDam5hMFpV?=
 =?utf-8?B?NWp0S3dUQmR6UlpENlFQMjJESjNnMmFBMnNTSlV6YzFDVUQ0WkhuNzJZR0tm?=
 =?utf-8?B?eEowZEp1RDFCNUZYejUyc3hYcERkajJxWVZsOXhFUkIrM3d0M3krbC9DUlJJ?=
 =?utf-8?B?UURld0RTbkNWUEhhdm54Smwyd1d3MHJjdzBOa1NabGpJKzBMT0YrbDZKT0l3?=
 =?utf-8?B?cWFRMzhmdnQ4VXpVYzYvTlpGTlU2NkVyb2dRRzF6YlhIVGtiMFZzVmRyTndx?=
 =?utf-8?B?azJzRXVjY1lFQjk1Y1VyRGdpcXBxYVdtelFPMitPZVczSkJKT25TSXY4OVNU?=
 =?utf-8?B?Wm1LQVJQLzg4RnAxTVpkRzJWRG4rbzd2azhnUG5ZSE9KWmVDMzBiMDc3a3Np?=
 =?utf-8?B?UFBieFFlK0JOQWF2M2dOajdMOC9rNlBHL0FMbENaVzdTaTVXU0pGYmdTYW8y?=
 =?utf-8?B?YWV2UklQejg3dnZiWE9FbGFmZ3pORXFydDUvdmFpTUVpdlAvZk1pSVpXMlY4?=
 =?utf-8?B?UFFjQ0VVYVg0THI0SkRVc01oeXJHOHpaV1dmelZneDNId3Z5clNYY1pJYjRG?=
 =?utf-8?B?cWlJY3VhRkZhblBWc0pDSTNrMTh5OEluR1JPVWQ2am1lSmNsUnZuM3REUDlj?=
 =?utf-8?B?NldHRFBOS1pOR0oxaUZ5UjVBK09ZSnZTbG9EUW1ibUlleTh6UVE5b0FlRHNF?=
 =?utf-8?B?ak5IQUpkeG5kUXo2eHpZVDRINy85bWFaZiswdXRXeHZHeHpjS3pPS2h5anBp?=
 =?utf-8?B?c0xNM0xFTXlORkQ0WXBFTndTNVhOWHlQMCtWTktZeUlqMG4zZnVndzg4QVh6?=
 =?utf-8?B?b3dGbVZzMGZJTG41aG5FdEkzUjBNREtMRnNJZGMwVmJaVThLVEFDWithN282?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eff63c3-a249-487e-625f-08dc637bb1c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:56:49.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Fo3HSpKi1S3Js6bxJtdwfVvCsMnuM279enWOH2gYCtxR4cUYmKRbvbZvD52khB/J4WgnIEdm4yXhH2100CH1E++38no2ERyQkAvPq5heHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 09:57:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15733



On 4/23/24 11:29 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-04-22 at 16:09 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0doc/README.tpm2.encryption.md | 12 +++++++++++-
>>  =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/README.tpm2.encryption.md
>> b/doc/README.tpm2.encryption.md
>> index c5ac6c4..a229d86 100644
>> --- a/doc/README.tpm2.encryption.md
>> +++ b/doc/README.tpm2.encryption.md
>> @@ -44,6 +44,16 @@ Each entry uses the schema `<partition-
>> label>:<mountpoint>:<reencrypt or format>
>>  =C2=A0- `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting
>> content of the partition. This reduces the partition by 32MB and the
>> file system by a similar amount
>>  =C2=A0- `format` creates a empty LUKS partition and creates a file syst=
em
>> defined with the shell command given in
>> `CRYPT_CREATE_FILE_SYSTEM_CMD`
>>  =20
>> +#### Encrypted root file system
>> +
>> +To encrypt the root file system the variable `CRYPT_PARTITIONS`
>> needs to be set to:
>> +```
>> +CRYPT_PARTITIONS =3D "systema::reencrypt systemb::reencrypt"
>> +```
>> +The mountpoint is empty as the root partition is mounted by another
>> initramfs service.
>> +Both partitions are encrypted during first boot. The initramfs opens
>> systema and systemb
>> +during boot.
>=20
> Does that mean, the .swu file still contains the unencrypted
> partitions? Or are these partitions encrypted with a fixed key and re-
> encrypted on first boot? How are the initial keys distributed?
We can enable symmetric encryption on the images of the swu. Which are=20
then extracted on the target.
This images are still encrypted on first boot. So this this means the=20
device needs to boot in a secure environment.
Initial keys almost always leak ;-).

>=20
> Before documenting the technical details, please document the general
> deployment model, goals and non-goals, as well as security and
> confidential guarantees.

Sure i will add a section in the README.
>=20
> For me it is currently unclear which kind of problem we want to solve
> with this approach.
>=20
> Best regards,
> Felix
>=20
>> +
>>  =C2=A0### CRYPT_CREATE_FILE_SYSTEM_CMD
>>  =20
>>  =C2=A0The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command =
to
>> create a new file system on a newly
>> @@ -59,7 +69,7 @@ based encryption:
>>  =C2=A0 - jq
>>  =20
>>  =C2=A0## steps to convert clevis to systemd
>> -The following script shows how to enroll a systemd-tpm2 token with a
>> existinng clevis based encryption:
>> +The following script shows how to enroll a systemd-tpm2 token with a
>> existing clevis based encryption:
>>  =C2=A0```bash
>>  =C2=A0export device=3D/dev/sda6
>>  =C2=A0export keyslot=3D$(sudo cryptsetup luksDump "$device" --dump-json=
-
>> metadata | jq -c '.tokens.[] | select( .type =3D=3D "clevis") | .keyslot=
s
>> | first' | head -n1)
>=20

