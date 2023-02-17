Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F82C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:00:24 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.42])
 by mx.groups.io with SMTP id smtpd.web10.8369.1676646020772171777
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:00:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QtP4s+jN;
 spf=pass (domain: siemens.com, ip: 40.107.21.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIwDiRpi9Pb8I7xLZF60IkO/CiYu1iLnzhv/eYwCsxNa+qtLYDRGco5xTm4rUtQQI+1FFQaCHRRMnVzKbt61bFlZGB55+y8jr3urnseokd/GbYZiNk3cWmraShXO0wVnySaXhEOUE66X0tZikCIT0gLCF4V/7/0qcQFQ4twiu8oA8Srfx4UZJHwFV8GdK0yE34Ogja5CM15yhjGlboUCZ0pc3lCHyD1uf4/g6NGWRO8f3y4e2LDZl12isvv5rhKdMylusdHaV2+UUg8zfoZyxRwkOKaRkOPuZ11+S9B0S36B9xuKjlSCRL2fzWvOCqpAZ+xL1HNh8bS7v+f6OfayYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk3etnxXsSxNEp/wTzSw9x7v3MjsLfpC0X9jcRFyQvc=;
 b=YTXEMp1J7TWluF0vCPxjg5fytlXPpjoZJThjvU+WhwN6we8I9c4NXugwmD0fusXGMnQ1QhzXWxih+S/ljHSJ2LhZUIIH+HB8F4QbbfboQyGcXAoS2Wl3nNckKZ/6m5rL0ktp8JhL1lxNfXa0gWLgAC/CTGbOoEpquqfHDfKhiTHZgDY2GBsEphKg0ETN5xVQMI3gUqIB5xKCu+PHNyl+0M5US/PVOLf5K6VqCgFZhunO1iQDWa/zqbN0wVSFqxNkRSb/ZfBVHkwXB53VZGhW6rxubrslxZ1R7F44IhIkYRsj1CMDjriNjnzV2k+8tIVA+T9aODJNjgjpEIF09KHfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk3etnxXsSxNEp/wTzSw9x7v3MjsLfpC0X9jcRFyQvc=;
 b=QtP4s+jNNYoheZXgOosmAY+IPykgQ/5Kq8yaNMq10AEmJYVG4AFRcf5ImxM1IR23hpJloOi1GYNIVpaWFWQaB/zrTso+ac1hs6sCw+EuMHoieJj92tlH++3diZNafjju9I8+W0GzUOYn5qIZpt+Mb24IHFyPDlmRd3Evkbti5SAMIzxZU0nEilonr5iZvxYkwZaXRTZg7TEQSrrwH83ieQtyeiKfCPRiWnn0WGUj8nNzIPmmj3GYjBPcBDpjBOQEQNQ2c+o8OfYd6V7XuPJOOjmaylLh/6Dge1kcOLS9yzNVMUSpQN+B3tyMmroz5T2ZTQT+T3gqZbnmEbG+Xo9hIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:642::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 17 Feb
 2023 15:00:17 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%5]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 15:00:17 +0000
Message-ID: <e7b31bad-7abf-2dff-b737-f9cc30e90697@siemens.com>
Date: Fri, 17 Feb 2023 15:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 7/7] .gitlabci: Add ci build
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-8-Quirin.Gylstorff@siemens.com>
 <787c809c-35ba-d9cc-0fa2-0deee3e3288f@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <787c809c-35ba-d9cc-0fa2-0deee3e3288f@siemens.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020500020608010305000703"
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d326c0-30ab-45a4-a876-08db10f7ae5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1/FzAMb7XvQdn6ZmZc/r9YnuthDq/lbzTR4js3vFhIMc0SuwzBHpQu0YjtOO0qcG60wu91xOOb/haaBvSNrQIS2zGP2FAVwIO9k0Pl84IzqSuyzzbHSbW9VlzQYIA/8Aj9LbvAqQ4WzF2j+LOknxO4yRgs9cCDggYttGlxjDFDVDDOWH8iAEx0J31P/sToVbq4lR6UM3Ej9cLarm7YVsDKwY9TZY6Qq5/DlBOU/TeQi5P3f3hs7UmnsmDSD99azGztsjpMwc7L2z37hIKWtauKR9u7yyhEag0npNKauVRlAaOuDCR/Y/hVpfRlVf+6ni1UKfxGXd7aQlsqVz6EvRiINXCwtvbu6OwbymxURMGFlZbtl3ZcTDQEZ7D6elj1eojhf36QzBpufIw0t+Zaeu1FEYt9wTeuB7etSm8wfRg3rVDOJ6FQFQCaGPoJDaKvUZOTEzurzWD/TmdeTBMAO8w0Jwyko+2ITameLgq/WIP+ssgEAZi5Jy2YbKgoix9rMuWz+lBXPshkDEDnHud3yloJLpZMTdHbGypVHkFI9dPNX8Mz10wEvqTT5vII+TqU8qe6CiRBWVZIK/J+YmCQqCfB1qWe/HOykLyZm8T6IcBE57AjTkqHPT+zBNcHA2aX0msbbqzH+AttMQT+fTctorFDozF00VoQy4JvrpBgZI2H1lPNhi6oLxViLR2lPcuGxxXKNhvd6BN4qmyaKRfEL9C2IbzVwwIJdyY7EAL91r+DQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199018)(86362001)(31696002)(36756003)(38100700002)(6506007)(8936002)(82960400001)(66476007)(66556008)(5660300002)(8676002)(66946007)(186003)(53546011)(235185007)(6486002)(6666004)(41300700001)(478600001)(83380400001)(6636002)(316002)(33964004)(2906002)(6512007)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dExGZStuWUFtZjhycEdjV2QyN0RuV1N2UmpPWFNXbUlmcE9uTXFNWnoyRnpG?=
 =?utf-8?B?N2dwcFVrQVFKdWhwOEswQUJ1SWtiajFER3U4Z0NrMFEzYWljNDhGZGd3YmNH?=
 =?utf-8?B?amNMMWlBc21WazA5eldtYldHQXYvaVp4OU1CVEo5MU5zZjBJaDhPNGJCcUYz?=
 =?utf-8?B?VC9kR1FMQVp6akN4UERJckxQL2QvaVdEY2toaTJUNVJqVkk1ek1yZzZWay9E?=
 =?utf-8?B?bUNocUMyaTVpS2ZSRkpMUHFDc3k1eHZiTUE1RHZBTStrQ2ZiYnl4TXRObWxF?=
 =?utf-8?B?ODZxS0F4eUVtc0xuMndBMWVydWFRbTBmY0pDTU50eVZyUGVORU1SMkdVS0ZK?=
 =?utf-8?B?blBNVlJkMHpjS1ZTdUN6dTNUQVI0eGRmQ053U2pWZEhQNnVyaXk4Z0UzNk5F?=
 =?utf-8?B?d3ZuNXMzZ1VzaWJEYzhaUExsaEdyVFdrQlhaMXprVWpzY292ZTdrQXN3eDBt?=
 =?utf-8?B?aTVhbHAzNTRyL3BuM2hLSnNCdVFHNWl5RmF5djdTYjZ1d2lOayt4MU1rK3ZR?=
 =?utf-8?B?dlg3T2F5cVFoNjh5K2dxWjRhTi8vWDYrWEE1NWh6ZVV3TytPbmw1K1gzMjN2?=
 =?utf-8?B?MWZUUzVsU2ZndUdIWDQ0Z1lFRlBvZWdtODZXeE8wVGg0U255VURCRCtyM1NI?=
 =?utf-8?B?cE53Z3ExSGtFUXBTalZpSlN4azlDVjYxeHBPMWFYdm9VRTVYc0lYLzdVSmVu?=
 =?utf-8?B?VmJ4YWcrTnVRb2F5akorWlhKaFFHZnhHc3dhT1AwT2lEYVllaTQxeW1DMlgx?=
 =?utf-8?B?aVVwUVNxdEdubkNlY3plQm8rekhNSlA3ODhCS3VQYTV3NzA1NE94TUlRQTVl?=
 =?utf-8?B?Ris0OFdlUG9BZmg4M0dCMmFkU0NvM1g0S2NxYkJJbGs1R3VxWHl3RzBma2Rn?=
 =?utf-8?B?bGcwQmE0aC9YdWZTYTYzWUN6MlZzREltaTlmUmttZGFzL25oMkwrdmx0YURz?=
 =?utf-8?B?RUoveEZ6dXhudjBCdUNZNm9jS2ZpdTEySEFvclJMKzBHV1pFVG85OHZ1RTBQ?=
 =?utf-8?B?OW51dlcrUEYwcVc4Nk9rVDJabXg1aFJ4aS9Cc0QwTXJNMkM0Qk43Nkx6Wnhl?=
 =?utf-8?B?c3ZoMWdZcVBWVEhHZkh4RWRQMVdMWVlBYk93Z2x2QXQ5cXV4Mjloaks0bExJ?=
 =?utf-8?B?Q3QwL2UyeXBZV012dld5VDdnMVN4UzVnbm1KSmZFK3JzVmtYSzJ2NkVyNUQv?=
 =?utf-8?B?V2pieHpkTWhpaGh5M3VNOFBpejVTQ3RPbnZoK2daZ0ZPQUVGV3dJdjJuMmpm?=
 =?utf-8?B?Y0huTEYzTnp5emZJRDhFQWRXZHBMQ2pOd3BsSlB5cS8weGYwY0JpS3R3by9C?=
 =?utf-8?B?WnVhaktMaU42TFBGNE5zVmdZVWM4d3JkRmxBRGRtVWExcDVxMW42bVF6Ymgx?=
 =?utf-8?B?bTFES2JOL2lUOEFiSWJ4R2ZKeGd3YkF2YXgrVUwvcXh6N01GL2orK0I1REQ2?=
 =?utf-8?B?bmpxUVM2VVV5U0pSOXhLeE9NVnpWUXBGaEJjUzBreWRob3VlaXdSeE5sR0xC?=
 =?utf-8?B?Tm04YUFSYzlVOEVmYUh5OGprMHhNMkVXK3MzRlhrcDJoRFNWQUdUY2V1eTBT?=
 =?utf-8?B?cy9aNVNEUzI2Y0VYblZyYnVYNjh3djQvQUtQUjRheUlIK01mRlcxMnoyQVNK?=
 =?utf-8?B?NTdhV3AwOG1FYW1LY3FxZ015bFUvRjZQMWN5M3pvYmU3NkVGVk0xdCsrZllw?=
 =?utf-8?B?SUxJdExWQ241N0xDS1NocHkxdm96MUF3ems1eXhJWUhiV0xOTE5nZ3Z3Y3hJ?=
 =?utf-8?B?S2J3aS9EcUJRWmxRV1k1VUFDVk55c3VNM0tveWl4WTJMcC9FOFErdm84R0Fs?=
 =?utf-8?B?TlNJVzErZVc2M0FyQWs5ZTQrUGI4VTY4cm1JYnVkTTNqQjBWb2hwKyt1M0FV?=
 =?utf-8?B?cXRuM3RYZlNWZjRpT205NzVmbXNmSUltTHVoNXlFV0R4ZkZFeEtKRlNSWHFS?=
 =?utf-8?B?cUxabW5vbUsxektUNmZucUZyRmh3OUtqd1VaZnozUWt4TDNVNFArUUZxK1JI?=
 =?utf-8?B?YUNEZ25JbzlWWHVac2RtRlplUTBieDBrL3VVS0VCOTY3SThxVUhReEZGWHh4?=
 =?utf-8?B?ZGpnVFZnSUNMQTNaWlBhUTRCZVB1T0xTMEZXTmc0aVZQOFg0Zk44RHpnLzFt?=
 =?utf-8?B?MFhvdG45ODZTTURsclFpdThWajJ6cndhTTJSL3R4VFBDTXQrUHFHSGhnOVBK?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d326c0-30ab-45a4-a876-08db10f7ae5e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:00:17.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FzTmEA1067ZdYBM3i/ea6ddt5PWwulwTfA32CevoPrp1AsWxZK355iTMjaN+mFuuD1mfCFjFFzkCxDZmZg5rgoXWNxu4vC9XUTJThzjkvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7687
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:00:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10725

--------------ms020500020608010305000703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/23 15:55, Jan Kiszka wrote:
> On 17.02.23 14:05, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index f7c8c88..c6dcab6 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -5,6 +5,7 @@ variables:
>>     release: bullseye
>>     extension: none
>>     use_rt: enable
>> +  tpm: disable
>>     wic_targz: enable
>>     targz: disable
>>     dtb: none
>> @@ -37,6 +38,7 @@ default:
>>       - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>>       - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>       - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>> +    - if [ "${tpm}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/tpm.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>>       - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>> @@ -206,6 +208,17 @@ build:qemu-amd64-secure-boot:
>>       wic_targz: disable
>>       deploy: disable
>>   
>> +build:qemu-amd64-secure-boot-tpm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: qemu-amd64
>> +    extension: ebg-secure-boot-snakeoil
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    deploy: disable
>> +    tpm: enable
>> +
> 
> Do we then still need to build-test the non-tpm swupdate variant of
> qemu-amd64?

I currently use the non-tpm swupdate build as a check that adding the 
tpm didn't break anything. But we can remove it.

Quirin
> 
> Jan
> 

--------------ms020500020608010305000703
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
GTAwggdkMIIFTKADAgECAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEBCwUAMIGeMQsw
CQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQMA4GA1UE
CgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjMxHTAbBgNVBAsMFFNpZW1lbnMgVHJ1c3Qg
Q2VudGVyMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIwMjAwHhcNMjEw
MjEwMDczNjM0WhcNMjQwMjEwMDczNjM0WjBlMREwDwYDVQQFEwhaMDAxMDhZVTEPMA0GA1UE
KhMGUXVpcmluMRIwEAYDVQQEEwlHeWxzdG9yZmYxEDAOBgNVBAoTB1NpZW1lbnMxGTAXBgNV
BAMTEEd5bHN0b3JmZiBRdWlyaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCA
qN/x1wdiSvw0dSlpuclq8Fwi4S3ldLu4MdKANA3DfDb+nd5jbRSKI09GYII3iFV4YkNDUtlq
73VQoJX0udyZM8JoYQ5Z5HaOBNWcXTcjL48LKsZrKsk7UUP2FBn3/bR9VGslALN+8em+6qVr
ZDkxVfRl3xEMi5EgVtorSAIP/RfspM9XWb/WhZJCASsl4fY8+pOjrGxQnitRc6VYXwUZAM7r
L1qX0eLGwAnaa8b5OvNtAxE2VVkAjyTnE5NoiCnbsi6Q+zX3/Ai8zv4pqkbUsHNoLg+qzJsa
CdD5TtfpwNgJgdQfD6Z0F89b7Xg36G7KZllulvicX62fFqzwx2dlAgMBAAGjggLUMIIC0DA4
BgNVHSUEMTAvBggrBgEFBQcDBAYKKwYBBAGCNwoDBAYLKwYBBAGCNwoDBAEGCisGAQQBgjdD
AQEwHwYDVR0jBBgwFoAUtvmR44WfDDy2iXJTnkE0jXAq+b0wgfcGCCsGAQUFBwEBBIHqMIHn
MDIGCCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkIzLmNydDBB
BggrBgEFBQcwAoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWkIzLEw9UEtJP2NB
Q2VydGlmaWNhdGUwSQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpa
WlpCMyxvPVRydXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9v
Y3NwLnNpZW1lbnMuY29tMEYGA1UdIAQ/MD0wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMIHKBgNVHR8EgcIwgb8wgbyggbmg
gbaGJmh0dHA6Ly9jaC5zaWVtZW5zLmNvbS9wa2k/WlpaWlpaQjMuY3JshkFsZGFwOi8vY2wu
c2llbWVucy5uZXQvQ049WlpaWlpaQjMsTD1QS0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dIZJbGRhcDovL2NsLnNpZW1lbnMuY29tL0NOPVpaWlpaWkIzLG89VHJ1c3RjZW50ZXI/Y2Vy
dGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAdBgNVHQ4EFgQURT1zRzKUlh+WlA5LZInILLrGEJQw
DgYDVR0PAQH/BAQDAgQwMCcGA1UdEQQgMB6BHHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEALJcoEKoIAxLyJV+6HTpKciBe
E3w7ht2RSQjG/7EAgjf+kW0Nrp4TyrzteHR3A2sTmRJC2M7/DV763W93qPzPiinqtNlUEDte
KJlHBfr0OUio7i0RZqGvlCGPK1R6lu6e3n7NtApww6nPAveS95UuJnkYzO3gI0I2gUYqzTeJ
BYLxC++jZeO2Va1vSDnNjFUrcLoPrDeU6T3uLXrOF/3XMKlfiXIybQZoWPgNhVhu6N9lJAJ0
2eHQQVWeoaQKmoNuAki/YE1guHR+Rz9dyYa1vawjDNWX8z7wZzNq5c0riHbHYfDpYEfcfli5
/aQB1z3Zgz5SePHBkXMsf+jSrDJKAqmaSyhn4xFpxo8ZnJWQwDg1KbE33/bL0LpGMK7D6JmK
dk4s6t/717RYywFqBvBELzKYKnfQqSQy0AsuGOmrVKXlQXKc3IotXwreL6MOLuzGuNuPuXHi
NgZFiZC09CfWqlJFWTrIsLoT4KXoLqGOM7kjBDoEAaM+QAsy/aFPATsXv+KPfGcK8o5hziPY
g/HTh/c80ZPxq7H87VzCxgu20vxq5rMe6GUZTkTF2YKajVhFbFKp+bM+Uu8MOXZ6PNgsTmzL
8PqdrRK3TNT1S7v6wEQ/oeceSE6RDg6A89vg5QLWIAYMHt30IO/nTXgdL9uAcTuQLjmkWmiH
fWWqzhyrQVowggeEMIIFbKADAgECAhBavnHi3TH66Ts7d1icYK9VMA0GCSqGSIb3DQEBCwUA
MIGfMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQ
MA4GA1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjIxHTAbBgNVBAsMFFNpZW1lbnMg
VHJ1c3QgQ2VudGVyMSgwJgYDVQQDDB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDIw
MB4XDTIxMDIxMDA3MzYyN1oXDTI0MDIxMDA3MzYyN1owZTERMA8GA1UEBRMIWjAwMTA4WVUx
DzANBgNVBCoTBlF1aXJpbjESMBAGA1UEBBMJR3lsc3RvcmZmMRAwDgYDVQQKEwdTaWVtZW5z
MRkwFwYDVQQDExBHeWxzdG9yZmYgUXVpcmluMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxtputBhOSIjdX+ZhaIzZXOkmsV3YBSNTrnA4MTG+TtL5wgss1pfH/YFV8CHLacVX
/cYnD09uaxevNSGV3rRLZF7A77gNl99BE8qqHPAXoB+/ZVQHzo3QdumqpqaO4bqTQYsk+jYC
eDEIlGyzDep9EAMdLK9jWoeYG68ayc6G062I0f8MUHC+oY3G14O454N487PcWj66UMh9zqGS
z0lk5AuGpC1xSks42Fs9TxNgLlh74UZPUZZWtp4+05eyyDay/kkuztI0jJmYMtg0ft7vGOuU
MzFVcxau7llvsv6z94ep/rmC0n+W0lQbTg9FEkeAE/ui/9uE5SqeMp4DSPk5MQIDAQABo4IC
8zCCAu8wKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICMB8GA1Ud
IwQYMBaAFNbv+6fnKrHAXUxohcItj1ZmfoLuMIH3BggrBgEFBQcBAQSB6jCB5zAyBggrBgEF
BQcwAoYmaHR0cDovL2FoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpCMi5jcnQwQQYIKwYBBQUH
MAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpCMixMPVBLST9jQUNlcnRpZmlj
YXRlMEkGCCsGAQUFBzAChj1sZGFwOi8vYWwuc2llbWVucy5jb20vQ049WlpaWlpaQjIsbz1U
cnVzdGNlbnRlcj9jQUNlcnRpZmljYXRlMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zaWVt
ZW5zLmNvbTBGBgNVHSAEPzA9MDsGDSsGAQQBoWkHAgIDAQEwKjAoBggrBgEFBQcCARYcaHR0
cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzCBygYDVR0fBIHCMIG/MIG8oIG5oIG2hiZodHRw
Oi8vY2guc2llbWVucy5jb20vcGtpP1paWlpaWkIyLmNybIZBbGRhcDovL2NsLnNpZW1lbnMu
bmV0L0NOPVpaWlpaWkIyLEw9UEtJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3SGSWxkYXA6
Ly9jbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpCMixvPVRydXN0Y2VudGVyP2NlcnRpZmljYXRl
UmV2b2NhdGlvbkxpc3QwHQYDVR0OBBYEFJc32FVWG9Weg/eke9wkqBgOTMDHMA4GA1UdDwEB
/wQEAwIHgDBVBgNVHREETjBMoCwGCisGAQQBgjcUAgOgHgwccXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbYEccXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTAMBgNVHRMBAf8EAjAA
MA0GCSqGSIb3DQEBCwUAA4ICAQCOXIgWGNMyJfE4Gbdgzqirk9am/SdeBV32YV5ZTNz43Zre
7Z3LRqtrhr09B+BfB/gfDcxAMwQctI15BwW90Yj7IveAf9/vWf3XPkUOLjc5Yicd4ABlWsvG
kZYK7UihD51ZYzDh3Weym8pp25LPLUA07M4+0s2J2RFxz0NqT9Ab0N9zqQKP4lCTM2nHh58+
2QUNlKGGyVG6cQkiZffWp260dL8sliUR96FMDHT55PYv6GoNOtUqA1rDpk4seZQFxDwBNW+E
E1DdKD3CXNMOyv4ZuUjjQvjhS1gleaVMxD+k1vTV4jFW0nnNX4uYCyT4KVdDlxtvs3xSVkZV
DWm2u+zo1biCfgGFtWb9ZfC2hv9GdOr14MJWONF3QDC4uINewUFdsAcD+nGab/7FiAIYNI2r
BDsih5BgMuWHIEJKGKWykFWkh6tjlkaEyWqdoFMpeVzd5wlp4fP/wZ7xg1OddBnhbYb1nCuC
xtYmQfSh9/Xp1u6WQMLYaQHvTULBVCeGzClFY4FPutT4pO7RS1F5L0GaFnjcIsiBp5I9ICAZ
PSdnIpShfEm47olJARhAx29FBN5JlisbzveSNBuNHS9QH5II0K7AClrOcATYO7hnxktvMh60
V4q0S6YD90WWkkRnwv7R3M9Zpohzs0kot3z0vsivYPDq+50h+kABUbjvO/x/bjCCCjwwgggk
oAMCAQICBGAcg7MwDQYJKoZIhvcNAQELBQAwgZkxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZC
YXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwha
WlpaWlpBMTEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxIjAgBgNVBAMMGVNpZW1l
bnMgUm9vdCBDQSBWMy4wIDIwMTYwHhcNMjAwNjI0MDk0NDU1WhcNMjYwNjI0MDk0NDU1WjCB
nzELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAO
BgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWkIyMR0wGwYDVQQLDBRTaWVtZW5zIFRy
dXN0IENlbnRlcjEoMCYGA1UEAwwfU2llbWVucyBJc3N1aW5nIENBIEVFIEF1dGggMjAyMDCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMoDusEPTAOAEOTwI7QkSd3bwzwKSgMb
uzXxUPaoYsEWCApzGe4ezh9ZZz00w9+lbkiSnuEkWuwX+FP50LLkgP1NUksigbwtsZ3dODeB
/H1GVg+5cV4oaWB3Rht5ePYFCROwskp4lUS6DGlunKc+t2NBkHesB0EWeiaJeZSJn0gAt2aj
FyEVP2wpwRHCaR/SjwmQPfCU1jqwuuU0+zS06ELRdS8rBiN0PXstS6Iboy+3jPpPlKnrtAum
jO2NTsfDBDt3q18+ZO48oKZENPda4FGfF0mxGP+0Xr0OII14W1bCMUwFEP/4UWlvFvtjpjUq
orhWV4bxJGe7E/oZ1nmmRn382sl+N3v2Ml/yyb59m7RChDRCm2QC2nvrzfi0hN6oPOa2VHZs
yqepMYHKJvBej2vk/twapZRsY43vbPztA51XFHcrdnJbsqH9RYqXVu4M275l0SN622V1vzsj
+kgMKXIxHfxT7jAl9v8HLFLTc+e9Bre29W1+wpw0d9qDbGGQYO+UN31TusMxpIhT1F5tLkeZ
wTLXUlFwA93cGTpArtn7XS03qCJ3E2IeUcwZydQOwH9FNTBIhUva0WXaefe2YofuefjC+Xox
FjvKzs1NeI8TarI2B1al9iruu2bzP72mS+jWdvk6KukQXEAtrlfaMLc+TmseQGmOxpD29HPK
dphnAgMBAAGjggSCMIIEfjCB+AYIKwYBBQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxkYXA6
Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpBMSxMPVBLST9jQUNlcnRpZmljYXRlMDIGCCsG
AQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkExLmNydDBKBggrBgEF
BQcwAoY+bGRhcDovL2FsLnNpZW1lbnMuY29tL3VpZD1aWlpaWlpBMSxvPVRydXN0Y2VudGVy
P2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29tMB8G
A1UdIwQYMBaAFHBtoFDsqdAsZ50ZFf79BHM1w+LUMBIGA1UdEwEB/wQIMAYBAf8CAQAwggIc
BgNVHSAEggITMIICDzA1BggrBgEEAaFpBzApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNp
ZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCATApMCcGCCsGAQUFBwIBFhtodHRwOi8v
d3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMBATApMCcGCCsGAQUFBwIBFhto
dHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgQBATApMCcGCCsGAQUF
BwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCAjApMCcG
CCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMB
AjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGh
aQcCAgQBAjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wNwYK
KwYBBAGhaQcCBTApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8w
NQYIKwYBBAGhaWMwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1aWlpa
WlpBMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNpZW1lbnMu
Y29tL3BraT9aWlpaWlpBMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9WlpaWlpa
QTEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDAzBgNVHSUELDAqBggr
BgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCCsGAQUFBwMJMA4GA1UdDwEB/wQEAwIB
BjAdBgNVHQ4EFgQU1u/7p+cqscBdTGiFwi2PVmZ+gu4wDQYJKoZIhvcNAQELBQADggIBAFAr
jdme0uraRt5tKTzku+CORk9YnWvp+waEbNw3rQfUuuosObdJNmOMD/j9zv0lTELANwSNRP7Y
jhwyrWDycV80FbhK9EsIUh3frSCc1sbd3/9eGzkMsgSuY60GIHydwsZQe9JFyRDCCO+Rfz2G
Xu+wKh8ENQti6w4U2ygQw2aqtIsFQVQDczqjisfNBkGVSJyp9yXxa2JOrEOjddx5yHf1pVTU
2kNPah3licDQoZ0mCZxyluULJw3RKOWjl9P8A2VpIAPqbeJgaWor+/BzkzvtQ3yaJB5PPGlD
2GFQNJRcNUpQdpDs7cAUkwToikr3ygGVUgImfHghnDDZaYG0twxefqA8+h9lDckAHI+c0VMC
DMt4TAn6bFohAcIpvtafQ+L/+k5hXaBKv//k+ESHakvZud2DAKxw4bssHoc1F/Sse5kGOsbS
O+Ht3igs7vVY6coaYXY0VmMscrJUJtlfySCvNmDpxcJnxxj9P+/h2hzXiQPfjinEj7P6jNQI
2O7Cik2TPY5XLVNGjz5xQrEFLMDyKIwNLdghRLhzMSn/PYo5bqasZ/W982lSGGOErw1XpKVM
sRCyuzWZ1q3sQRd6uJioIiUmj7/V/wHFh4kpvao4oEcQ2NS8NVEBIMRt9qt9XEjVXWWiHVhd
ZCuH/Dy0Im4oK1++s1MjHl5Hd5LqtrtKMYIESzCCBEcCAQEwgbQwgZ8xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5z
MREwDwYDVQQFEwhaWlpaWlpCMjEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxKDAm
BgNVBAMMH1NpZW1lbnMgSXNzdWluZyBDQSBFRSBBdXRoIDIwMjACEFq+ceLdMfrpOzt3WJxg
r1UwDQYJYIZIAWUDBAIBBQCgggJnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDIxNzE1MDAwOFowLwYJKoZIhvcNAQkEMSIEIE+Ccm9f7Vcl71K52gTn
e/SqNjlMu6G+1nzmUbsCmUo1MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgcQGCSsGAQQBgjcQBDGBtjCBszCBnjELMAkGA1UEBhMC
REUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEn
MCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM0
6383MIHGBgsqhkiG9w0BCRACCzGBtqCBszCBnjELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJh
eWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEB
AQUABIIBAF2h8tX8Nrjzc0hJxfDeQPbnoq7zn6Nk8cj+yqciQ/DnCtx89rpRNaSvXoxVeSbf
FXbVb1yH9bqIb12uSsMCURIF3wsfS/qx2dkq4wBmMHgLpn3FH+rBySR61fr3JChAAMhMdoGu
KN6mtE3oEsPACILOW9Z0/N5VN/lHC+m0rFl9/JM644MhHUsxRYURDaytzOvMqudnunj1O6ik
oElrKGBNyO/klnRFoBCkuHe9zza9T4FxbWr3GqajntoEIG+FSYhcIHsrzjhl7CfVW8ubfeSG
pfzwovssePBht51jD7APt/WSrGFbA2BvVWxrSRJJ3fKq74UlDffBkvSAEfy8MVAAAAAAAAA=

--------------ms020500020608010305000703--

