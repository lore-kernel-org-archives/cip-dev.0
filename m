Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CBC04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 19:57:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web11.7021.1715198222665688432
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 12:57:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=USZak0I2;
 spf=pass (domain: siemens.com, ip: 40.107.22.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCNIKzEID9nYkFfEF91oAuroaxsqzet0ftJMLkpqxs2uibrzwXIWPf4plgXsl9aYedzIKwxExyW2PlmDSu/YhXGaoaHDPWmDla3p5JCIZwNywhCtOvBeybPzpOPFIHwpaVraI2F4fvGwog/oetrf78aQG+5QOVP+KSVAPVqriYCLIbEcjaNwNVo12GHrafi9V5dD9aKQ2rYXhfYFtTAPPNzEVH/6gI6w7pgCCg+ID1zn5IvzF2Efx0r5GaaCm4+kQjOPGAc+DkW0DXQkSIPNvupp3Wb6okA4jqV/zKWFD1b0ccl4P8T5FA1cqA7ZEuEKnANNuBx+ifDNsDYXudCTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6JZvgZM7rH7BtJQYVM3g64+69hjD7dB2rZfA2G4fwg=;
 b=P/Sa4O7fMI+UvO5gSfNYUImnIGZEEKmZR0X+89rvnGIHWhAVbvHVu8DXQz9J/NT5shFi60rC36QIRUSQWGjChn5tSkV5/0Q358TJ4K1rENV5U/xJE58+8ZxZOzr5OGnQgPjiDBIc+G9t9xO6/+fe31VC5nn9J/14NkxJjP9S1vgRkKwTbP5lBJeo/omtICRqGyinOKk0SDsEHQxUKX+rsOpvuQfWGRz4JVDwzxH8QC7MohlIrzoDQwCYq3sXpia1nmCQFMzS+ricmsGMylj+assID+EhbBsDVt3MNyhVIhYWQ9StVo+3UrmNKg3pVGFoa126eIeqASigNRQYBsQurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6JZvgZM7rH7BtJQYVM3g64+69hjD7dB2rZfA2G4fwg=;
 b=USZak0I2s0aewug6od1UoWMvyh3mfWnr8zbIv4dTWjc+CdAfNSVnoTyU/clqRZawTQK89smBQeqzKkp+emhreK0CGYLvrdMhJkDsu4/Z8bxNl/L7zj2NsxEwkmQPRTfqFGVk8O02KQ2ngG2iI+dmHU87eCgfB0647seKPu01kcfa86oS06SWa1BDiZprLo4/fj7gAx7Hu6YuCmuQe7O9aM69UxkUPCha1FHl4OjAGAcQ39qcOy5tEQ4Tye//UPK/5AM8ppafqR6T12Y8CkH237542jp0/5Tet2UveLHg2YIGZX3S8Ds6cCiqUPBRy9cGWLJyMBmK23qxdB3wWgM9nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 19:56:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 19:56:59 +0000
Message-ID: <1a70b36f-8ef7-47e1-a3b7-e89a2eb079b0@siemens.com>
Date: Wed, 8 May 2024 21:56:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240508135539.2780114-1-Quirin.Gylstorff@siemens.com>
 <7272b70c-efff-4708-8c24-7aa67732d924@siemens.com>
Content-Language: en-US
In-Reply-To: <7272b70c-efff-4708-8c24-7aa67732d924@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 617a8aec-8ae2-4cd9-0e42-08dc6f99058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SzgxMEtSOUdpS0I5MzR2UHk2Z0xnRmtTOVcvOEhGdUhvalRiQlM5czlTUGVX?=
 =?utf-8?B?RGZlRi9kVGlSd20zUFFiSW14SWVncGFvaG1yanRNRkQrcG54NkxabE4vWlJC?=
 =?utf-8?B?cmRRQ1F3ZGxwNTFxT2N0Tm43NW5ZTUcxNFlwMGV3VVpnY1VFZXZ0VStvVFI5?=
 =?utf-8?B?T0Zoc2VSTHVUZU1ZVmNiaGlwdXZLZVoxdmh5UTBtMjE4ZnJQRmhQeTRCWXdT?=
 =?utf-8?B?Tk5hQk9kZ3N0aSs5SHg4WXhnYlBzL1JXZXlCZ2hDc09ISG1ZVU8zSUZFN1RL?=
 =?utf-8?B?TGx2MFM1V1ZBS0svbVNNa0MxMWh1alJEbXVtUVp0REhoejRWUnJWWk5RWElG?=
 =?utf-8?B?T1k1dzI3SnhLUXBGKzlXSW1GMEVSY050cDlmTE00c2hMcDhhamYzODVZTjNp?=
 =?utf-8?B?dlZOMk5xTDYySXVlY0RhaTZ6aEFOUkhJUlZEeWM3cDNxcXhFZ1VsM2xhaExi?=
 =?utf-8?B?ZHFyNlBFZ2hJVVI1VXh5NnorWmVuam1yK3V3Vkl6djROenBGcW4zMHJSbTk1?=
 =?utf-8?B?SXVxSCtPSEQ0V0tBMUMvUnlHQlE0bGluUGVPRnM5ek93M0RyKy82QjB2cWFw?=
 =?utf-8?B?MmZVR3Frdm02TGtURG1UNjdiN0h3WGRidEZac2V0QkVpRWd1ZkloTG5mdG92?=
 =?utf-8?B?R3hyREJIejM4aTBVMW9FVnN6YnJJdVYzbnN5blZjS0syOVV3L3F4YjhjV1Na?=
 =?utf-8?B?RkR0WXczY215VDFyYjR0THpzQytscE9KTE92N052MEFHQmY4dXFXMmhuZ0J0?=
 =?utf-8?B?S2wxUTI3KzhvUG1LVmtPeUdFSjJWSWk1MlhidVkxWTJrOHgveGc3ZUs2eVIy?=
 =?utf-8?B?QTFyOGxrR3ZGOWlKbXpZYmZxV1N3QkxOVldKOTcvMVNQcDlzY05QbkUxcUFD?=
 =?utf-8?B?U3JrQWo5dmUrUGVSckNrYk5CZGpGMEorWCtXOWw0ZFpPK1NqMCtnUXNIYkRQ?=
 =?utf-8?B?UDNyZnFydFM4enFzb0p4T1duU0QxMkxKRzRzaStLYUJ3ZnJrMFdIazhsdTU4?=
 =?utf-8?B?Z05teGtBaFNVRzNqb09uMmFEODVOWkFuK0tEVit3RVRzY2VzeW10NzlmdXoz?=
 =?utf-8?B?QTFpUE9HMVQvazQzeFJteFRSU0V6YmJBVmwxNGVYMnNqTzY1dloreUNPWXg3?=
 =?utf-8?B?empTbDV5c2dHdmZtSnBoQWpmb1V6dUk3VmVXOWk1U0JudVp3Vm04WmF1QUh2?=
 =?utf-8?B?b0h3YlVBajBjZUx6RGpVWU9HZDhXNTFZSHJYQ2JYMWhTMnNxa3o0MTdReVhs?=
 =?utf-8?B?RHRTb0diVFhuOHpZc211UVpSRVlaWXNDUituWEZiZkJFU2hQb1RQU2l1bmlw?=
 =?utf-8?B?b3g4UXA3SzVtaVZDdFdVUTdST2tQT3c3amFwRTROMmpxRFVaTkt3NWRQWmFC?=
 =?utf-8?B?WGNaM0RDczJzRkJ6eHhRLy9HRlN0MjJ3OGs1M3U5MHFicHFVd05CcE1Cam9s?=
 =?utf-8?B?MHErMjIrWFg2bnpOVWRyVWd0MGQvNmZES0Zuakt4YTBQREVIS3RqYVoxMTBN?=
 =?utf-8?B?ZXZibUlNZUI5NW8ySHhNR0tqUFhyRUJRUTlMZk9LdTJjQ1VPTzZKbXJoaHph?=
 =?utf-8?B?S1hLUE1rWTRPYVRJdUFzelhBaGNGSUE5ZnExRi9zSzBlcUJXZW5lYTBYbjVt?=
 =?utf-8?Q?pQdIiS7rzqEqi51A0PKz+HCvUiQeDUUYF+0TE3ltSwZQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVJBOERGMGFwbkN2aE5EbHNZM2Qxb1A0YzlxQ0dabXFGc2pKTElRZWdCa2hN?=
 =?utf-8?B?NGtzOXlhSHpZa0V2MUc1aTVtRHljcmtSK0gzNVZlWHVEdUtzU2ZINEZha2Q4?=
 =?utf-8?B?RTV3UG1iZEhxOURuS3BBQWN4YTRoZmRUdy9GSU05ekpmKzY4VWF4MTN0RzRW?=
 =?utf-8?B?cjhMeU03QXN4NHpMbWRib2toNzRMSjEyZzhCOFRXczV0aHVHV3I1NzVMNW1H?=
 =?utf-8?B?NHYrYlY0ck10Z3NlcXgxWldxanVXbVMwaElwWkxQT3YxcHV0enFUOHUwQTVq?=
 =?utf-8?B?aUZnNi9IZHRKSVRwb1ZVdFdMdUZKNjQwY24vWlhFU0RTamZKc1hGNXlJbTNX?=
 =?utf-8?B?R2tDUlJ5WUFXeGtLVktBNm54SVNnRHpRYlBqZ2h4d2Y0V2ZxZmxLZWRwSkN4?=
 =?utf-8?B?R0RMM2pvQ3JmUGVUajc0a0tZamVoKzNYb3F2aG1mQWpiUFBoSjBtWW9qMlZ4?=
 =?utf-8?B?VE12ZENMMkp3cE1OWUNKaDFGQU96V25DSXRuZkNZN01xOWQ2dU50blR3Z2Y4?=
 =?utf-8?B?L3R3V25rTzBCSk5BMmg1cURJVDlxT3IrQXJ6c0NnN2lFeTBEaUJMM0N1ZEJw?=
 =?utf-8?B?RVMrSUR5NkRSNFVRamRvMVE0VVB6eEpSTmJ2S2RYd1BINGhlZm9IR1YwOUZ4?=
 =?utf-8?B?cEN5NXNodXRMY1NzK1NFRC9INDlidS9WMXRWeDhFendZU1JKMG9uR1BvYWdN?=
 =?utf-8?B?K0JVSzZhTmd3TlhGanF3bTF0RVdmeUJBamJ5T1grc2NBdUN1NUFDRitQazdm?=
 =?utf-8?B?R2ZMTVV1Vm56bnJhd3IyZmZpSitIaTVWeHl6eWtVQnJZeSs0VC9mU2Y5V1dw?=
 =?utf-8?B?bXpoeitVMjZRQ0hWZHV0ZTV1dlJFbjJwSFBnMUcvb0piNkF3U1NyYUZZVGxa?=
 =?utf-8?B?MFN4aDhoUzBHVFI3STF4cjV2dW82MHB4SGE0Z0tqVVFtV3BZNTZLTXdZQkNl?=
 =?utf-8?B?TkQ5SkpURG5KTDZNUjBRVWRMQXhYZitsZVZwc2tWT25yN1BLUU1XVjFYUU1v?=
 =?utf-8?B?Q3prVE10ZzY2eWxtWVNCSm13cDIzT3JQNWJ0a3ZNWHNsdGRSVW94MHViMXh3?=
 =?utf-8?B?Y2Q1OVJpR0kwL0d3RnltdnpmeWJoYUl5RFJYNm5wb2l1bjYvZnFJRUcxVEtD?=
 =?utf-8?B?SDNLQTI4dWc1VWswUFBGMlh6akxkamdVOUdjQ3F1bXVyN0hzVm80Y2Mwd0JE?=
 =?utf-8?B?VTBXbWRaOWViM2lGTFV5RkRkK29Kd0ZzVmU2MXMxTmZNMGpVMjErcm53Z3VT?=
 =?utf-8?B?VEhPYlV2S08zRytGMU5yb2VaLzlHN0tRVkZFNjlZTnlBa2FjM05zUGtNYXZn?=
 =?utf-8?B?cWdiNUVzU3p5a3hRc3pPazI1S0IwRjZzMVpVd2xPUUpHYTdTTTFsWDdIaHk4?=
 =?utf-8?B?MUl1aUx2Vzdma0plUmdjQVB3MjBnYlMzd292YjJ1blo2dGxwVWRHbzJtblp2?=
 =?utf-8?B?NEt3d3N3VlVOazF0c0dCM2EzRDA3MWJHYVZTSjRNT2ZGQzhVeXA4djVVSEQx?=
 =?utf-8?B?TDBwYUdlSnJaVjJ2bWZHekRyTkMySkVoTFNCaTNxcmFqZzlTRkxwVmxWWllt?=
 =?utf-8?B?T3MraFRNc2xGM1REZFNHNlREblF0bWQzSy9EWGZiT3BFUjVpNC9acFRWWEdm?=
 =?utf-8?B?RUMxa3lNTHpSNnlhWTJMOWhWdG56UEVPSzFVdTQvNUhkL2tSU3lqWkJBUXVt?=
 =?utf-8?B?cWlLUzJlUU05bVQ4NGI2L0RVZGczZUZUaEZBS2NrZ3Vpa2o1bTR6S1F4bjNR?=
 =?utf-8?B?U3R1S3MrNE5LSjgyTjNyRmx3T213VEZDS1I4RzJyZ1REWGUyYUo3OEpJTmYx?=
 =?utf-8?B?R1NUd0hBeE4yVisxWk9BeWJXRkNlQm1sR1FxaXZDN0UxWUI5b21aN0FlS3pJ?=
 =?utf-8?B?L0VUZ0NQaXphSE5RMjNOTXRVcWc2bjNiSTBIL29NZW41em4xUW1GRWN3V0x5?=
 =?utf-8?B?TTNWSkVQaWNPWFZkdUtRNHBsbDlUb3BEcE4zWHlIREJwemFxZldBWThnb2FV?=
 =?utf-8?B?ck9ZZmhJZjNxRXVEOWlDVCszamYyd0JteXpyYlNrcXpVOGF5QjFKNGZxUlZo?=
 =?utf-8?B?QkYxRFBoaHd4Y1FLV2xBVUNLYThVNFpSZWFYUmxCcG1HRG9jRTk3Nm1IVHcv?=
 =?utf-8?B?Q1lsZzlRR0YwRlpLclZoeUJsTzlBSmdEWHpvMFRWWGVETUxxc3VKQ1hoajlv?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617a8aec-8ae2-4cd9-0e42-08dc6f99058d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:56:59.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W78gMsg5pCStvJS1U0x1FnXiDH0MfP6oJam2u9ZiSdOlRS1mp5Wozey0KOrb21NQLFpcULUnL9lHSkUePltrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8732
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 19:57:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15866

On 08.05.24 19:31, Jan Kiszka wrote:
> On 08.05.24 15:55, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the issue that wic arguments --size and --fixed-size
>> are not correctly interpreted.
>>
>> This fixes issue #104.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v3:
>>  - remove unnecesary setting of FAT-Size(-F) and sector size(-S 512)
>>    the sector size default is 512 and as FAT size should be caluclate
>>    according to the partition size.
>> Changes v2:
>>  - replace size calculation with part.prepare_rootfs_msdos
>>
>>  .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
>>  .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
>>  2 files changed, 9 insertions(+), 55 deletions(-)
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 4e3aefb..2b06fd1 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -136,40 +136,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                  msger.error("file %s not found in directory %s",
>>                              boot_file, kernel_dir)
>>                  exit(1)
>> -        cls._create_img(part_rootfs_dir, part, cr_workdir)
>> +        cls._create_img(part_rootfs_dir, part, cr_workdir,
>> +                        native_sysroot, oe_builddir)
>>  
>>      @classmethod
>> -    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
>> -            # Write label as utf-16le to EFILABEL file
>> +    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
>> +                    native_sysroot, oe_builddir):
>> +        # Write label as utf-16le to EFILABEL file
>>          with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>>              filedescriptor.write(part.label.upper().encode("utf-16le"))
>>  
>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>> -
>> -        extra_blocks = part.get_extra_block_count(blocks)
>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>> -
>> -        blocks += extra_blocks
>> -        blocks = blocks + (16 - (blocks % 16))
>> -
>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>> -                    extra_blocks, part.mountpoint, blocks)
>> -
>> -        # dosfs image, created by mkdosfs
>>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>>  
>> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
>> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
>> -        exec_cmd(dosfs_cmd)
>> -
>> -        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
>> -        exec_cmd(mcopy_cmd, True)
>> -
>> -        chmod_cmd = "chmod 644 %s" % bootimg
>> -        exec_cmd(chmod_cmd)
>> -
>> +        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
>> +                                  part_rootfs_dir, native_sysroot, None)
>>          du_cmd = "du -Lbks %s" % bootimg
>>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>>  
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> index e82e990..48f7523 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> @@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>                                                 name)
>>          exec_cmd(cp_to_deploy_cmd, True)
>>  
>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>> -
>> -        extra_blocks = part.get_extra_block_count(blocks)
>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>> -        blocks += extra_blocks
>> -        blocks = blocks + (16 - (blocks % 16))
>> -
>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>> -                    extra_blocks, part.mountpoint, blocks)
>> -
>> -        # dosfs image, created by mkdosfs
>>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>> -
>> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
>> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
>> -        exec_cmd(dosfs_cmd)
>> -
>> -        # mtools for buster have problems with resursive mcopy.
>> -        # Therefore, create the target dir via mmd first.
>> -        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
>> -        exec_cmd(mmd_cmd, True)
>> -        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
>> -            (efi_part_image, part_rootfs_dir)
>> -        exec_cmd(mcopy_cmd, True)
>> -
>> -        chmod_cmd = "chmod 644 %s" % efi_part_image
>> -        exec_cmd(chmod_cmd)
>> +        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>> +                                  part_rootfs_dir, native_sysroot, None)
>>  
>>          du_cmd = "du -Lbks %s" % efi_part_image
>>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
> 
> Thanks, applied.
> 

...and taken out again - there seems to be some regression with the
security image:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6810329484

Jan

-- 
Siemens AG, Technology
Linux Expert Center


