Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0127DC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:10:35 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web11.19280.1678713024229505138
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:10:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VD64za0p;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldcb44x3K+HJQ6lcSkNCFcNoNvM/KMkCkcyJfrkf6dbSqYHC0DXWn6zZqoJ2dtR/fd5MlFcNsZ2KUjyXYXPUXnSFcdzMwiz1X53wO0lX8APOZ1kwaBEGwmGLh2+kAzZeQsSrULA1ra01flHtkGkSK8bagabxREWg2r+VJ3f4vl5pQxXrTGKCOUjlgNGqHqVFSqWjt9aQQ1Lso14HVMr7VhKIloA1n/UyTbnSVzy2IzLIwqKusw8yHUq43TOu6XWsPoMZr2Gx5TtAdOoydwLSmPe1cvUYCvLRmwL2nk32WXssDgWh/6S6/NfDoEgI59Fl7x9FdQx0/DgTs+aFu9lf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si32rAAzi9BWwsAF4IesiLjAW1+QXUQLdgHLlj1pOXQ=;
 b=lDcI6iRj486EOu8IL7R07lx2pCbJQAcRCWBCOtRPFHA8PSELqPE4rAUJi4Hk5z3BWekTpQLFTUKZmnRtlzXndN6EQrLk3RdbHtek7tfXCNpHadJ9OLUIZe07OwJfIE9UeJ+PNs7pqdhTT3eJkjPwqeYcpGep5Qn00K1H8tv4Ob5MVU1jds521nu150bEmzohJ83am9k+p91gH5m7Rg4seNyUT41SJBKArbyzs1lbcer7wVzGrSQLgCTuWZwDvJcC2NF3GHUOaLmeA4rsHQETLVbSxnSBPw/bD1izQ0j5gU/YVA+xrgM9Yn+5ivl53bAE79zEsSBf3K5qk29GCQrQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si32rAAzi9BWwsAF4IesiLjAW1+QXUQLdgHLlj1pOXQ=;
 b=VD64za0p/sOchvwo/wP0ouUJlrD5ybODxdC9ZrBE8Fs7cMUxvfni4/idkXQAZZGBKF09iYG0/UpVNZzxCL40VAyIq0JrWFC8oYNk5hS+hb3RDCgLQKlw51esSWkTBTkhtDh51wwztJFh3TNVm3aFdYnvwYLE0OEpcFVKFUEPZBpd+BjdnM3Vg+4EBBpqi9TCX04DVwNrFmL5rjRaAZIy50OXWsGplTexbFfMEvovR1N0OW/yj11hJDWV1RwBxwmYCuKTvsu703yV88PfAQ9o7isxwnBlW8OFGpimV0DEcIX/iv38IZ/lpYlfkYhL9NAXfHyJ05ZDyPlYhfw7aNqjIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:10:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:10:20 +0000
Message-ID: <79fb4702-f35d-9176-014b-f009893f6c30@siemens.com>
Date: Mon, 13 Mar 2023 14:10:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 3/7] start-qemu.sh: Create a
 tpm2 device
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
 <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
 <e5d1629c-7b48-da7f-d39a-14e8c45c0555@siemens.com>
 <c55fa4bc-41e9-fcb1-07db-b6f39bfc110e@siemens.com>
 <fde29081-db60-d0d3-601c-113472f52616@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <fde29081-db60-d0d3-601c-113472f52616@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: df62195f-b1da-46ff-64b8-08db23c44c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l4T1ANlRWMgcEusk68I0KUaxs91KIgSEB44CUIWjhc4gbT1YDXzNjUDyrWsWz4xBs5Ac++XgLw/8cgf6SvtimIYjEfW+f9vjSELaAL9Uir9fuxu8mQGk8SV40f4Vk40PUR5HrBZUr4BVpDG5t6HxnAvskuYxEl+oa/Re3xHG5cyl/9zrfS5CWW0lmhcc/4cn9ZHqkFBJvjhiQoTTkmSywTld5Pbo29WAtpe5ByCb2Mb6b2xx8dFkIJHdCli0fOJGNYrvq4R5zOOc+HzmyseBoXW13HO9+h9jgolxXTaHbnoxLg1g+Alz92G/m5CZ27V4u+5t1tFrOYkiVR6VwvwsIPhQlOlULSY32zKCkVcgyED0GJC+6Aixwo7ll8Gq3davgRiqLmIOkgLEt7ATgFj8ob+q3hJfLsc08/IQGMDcs4hD1TolVX/15k6W+agJmZjzTU2M1xe2eZLFDyBeV+uyL24Xn76azV3KGcvNKqmvLQchovvV2cc3+7in0qh25cJTkCQJk+2AfXHftKMDn5G9QPVyw4bqjjTvi8LbZM4MI8p2P5EcJsawC/mqIZvPyzY4DepczqNRKbQXEO+3xRGqEg7jCZ/1mAQ6GO/39HwbACPswvBF6odTHSrGZZjknXJ161oAT8ypC+ifmvPoC+iIdTAcR4t4kUuUMloBcBKKzxmMXL74SXbW11r5VeR6dceOoqXIEG3RK0g9n0fiRwA993mVFV2dmhULOsTQ78oaF/E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(31696002)(86362001)(36756003)(38100700002)(82960400001)(478600001)(66476007)(8676002)(66946007)(66556008)(41300700001)(8936002)(6636002)(316002)(44832011)(5660300002)(2906002)(2616005)(83380400001)(6486002)(186003)(6666004)(6506007)(53546011)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QgCk1oJxEg19IY8SITfS1QlrrNCsYmYpaC+5WdlYmpGvSHQullKrvwpJUiIH?=
 =?us-ascii?Q?dNJmoaOGX5Ga/8scPqulPFVulntnyrMGTLsQIgbeM9HCCTADYqZvdpuwi8rC?=
 =?us-ascii?Q?eLBUrZEiwPBCu9byUEs9C+47+K6abPLS2aXTRQl+CKpkJqbKpxiCgtupUxQT?=
 =?us-ascii?Q?M2yFchPR+5shoOBGiqPdrBh0u5sBLSnZSVNfiw1WMolrdr+W1QWVsB/1UQzw?=
 =?us-ascii?Q?P9X2ZeSFJLORIqgeVNvRXx/o/34dDbpU0ebjLmNwEtSKYe0cB/CxCOzb+zTZ?=
 =?us-ascii?Q?Lbpy7GNZ8FSWBqXDU/UnuLILukHLUL2Y/BqGPg4lwAjxwcpXKWHRUSAzkkL9?=
 =?us-ascii?Q?T01eGxL4BhksJQaT4r6Xf4ygrTTPnFPELvaQ5Oz8+vZOOd7jexwvbbey3UUo?=
 =?us-ascii?Q?gYsbzb5plsfdgCxGhEtu0uViZ0mi6zhMniyOM1Gi8zMpQpz+g1Io2+TpqDGq?=
 =?us-ascii?Q?y3mSf6A0+er83+4m3ZqEHG1URE5RlEmxepFcN3tARrmYBlR9vo+yTKrL0AGm?=
 =?us-ascii?Q?pXmbYI1/N+BlmAVD2ySgQnAmPo0Md+6rxnw8n7/4j1t8uAL14qXdf63FYvXj?=
 =?us-ascii?Q?cOxWOXHJnMMmPCRhM3GQk5bEHAwLHpWZnBHCnKVrYdvRRvknYc6avHccj+/y?=
 =?us-ascii?Q?W1Bipw9C89L/Lcs66WBMbnfbQNFEOAa08nnJNrGxApRsVzJUr9JvYzd5U39y?=
 =?us-ascii?Q?b0Pt7HkhX0D6/FAmqHqpyNiL58Z6qju1W+APTNKSdmLJmwhvJ6iJUb9b6Xms?=
 =?us-ascii?Q?NRYqSl1OkeOyeKYa43msH6kOzHjOIla9GrWH1gPBKscstnKhhmarVF3/l6u9?=
 =?us-ascii?Q?mvxztxMYvH/3S7SGXc1YXH7GrwHBDTJDT1ePFgRJOENILxtv0h9Dvttl2W97?=
 =?us-ascii?Q?arP4Bj83qDijsrEVGc1vHPFYjLn8VE9Yhu2fuY96RVBE3+s4TA1Anc/Q2Zff?=
 =?us-ascii?Q?v1gKmn5A+s/rQrfeK5B6GztGld0D6RCadOBvp7gn/lhYXBbFmj7jMZsqW+ua?=
 =?us-ascii?Q?dHl6ztrWbh2IOHhbj9j1GarGp17bJYc6CFySI7WgMYebG43cD73g4v77dPWc?=
 =?us-ascii?Q?vAUb7h05P2MeWHJKKMsij0A2aa+6pvETzx7KvJ0N1jNM8k9Q/tGT7XJNuBxj?=
 =?us-ascii?Q?JsYZns85HG9wrfETha0HiZhFJRCumXDbmsuxmrEhPNVcqBIXikjnCYdYg7P4?=
 =?us-ascii?Q?DI8Q0hzAmGXKoONrln3N4HaCr0qhMN5l5gUTwTZlm/xXnMSR68bO1sfChQKJ?=
 =?us-ascii?Q?b3K8/MTR+yfHQVkyGAMXKCKxFoZCi7mxx1oGri9jtI2PPA5hDzXSdBNQI/5b?=
 =?us-ascii?Q?ILtcgyLW0Ykfhhh5NzXDs3N1dZbF7/+vguuVwEepym9w/rZB0W+gYHGJCVh6?=
 =?us-ascii?Q?N5KdvaByS4Dxl8ctfcPPo/6dpErs8gRch9MMDxyeIgilAoG4Hjwrsy462Whw?=
 =?us-ascii?Q?c4os0Jda9Rx2kVoT2+0NPgtMIUBbcP8rQqPP7HHqpLolcgyuWJzjoNM98LPa?=
 =?us-ascii?Q?jmFP3mTmkWOY1S96MJI1LQHChs86Qh+sa0OckYVILmu8s50kaQaTMbeeLIG5?=
 =?us-ascii?Q?rF1/Fv/Pj59Np1M+WL4ep1BHBuylcLLYeFZGuptShw5Nt+Jh+9YZ7M5IX5cH?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62195f-b1da-46ff-64b8-08db23c44c6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:10:20.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtw3k/sC6tCO+wnr3rDPGMoAvCB6ooIFlPFG9n/0DPMj7eUfOIBg3/PhkYxQn8N1vWrlC9pxTRIT2qqIuEVJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:10:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11007

On 13.03.23 11:29, Gylstorff Quirin wrote:
>=20
>=20
> On 3/13/23 10:13, Jan Kiszka wrote:
>> On 13.03.23 09:13, Gylstorff Quirin wrote:
>>>
>>>
>>> On 3/13/23 08:08, Jan Kiszka wrote:
>>>> On 09.03.23 11:28, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> This allows testing the partition encryption with qemu.
>>>>>
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 start-qemu.sh | 27 ++++++++++++++++++++++-----
>>>>> =C2=A0=C2=A0 1 file changed, 22 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/start-qemu.sh b/start-qemu.sh
>>>>> index fcfbc5b..b46b066 100755
>>>>> --- a/start-qemu.sh
>>>>> +++ b/start-qemu.sh
>>>>> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true"
>>>>> .config.yaml; then
>>>>> =C2=A0=C2=A0 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; the=
n
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWUPDATE_BOOT=3D"true"
>>>>> =C2=A0=C2=A0 fi
>>>>> +if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
>>>>> +=C2=A0=C2=A0=C2=A0 TPM2_ENCRYPTION=3D"true"
>>>>> +fi
>>>>> =C2=A0=C2=A0 =C2=A0 if [ -n "${QEMU_PATH}" ]; then
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_PATH=3D"${QEMU_PATH}/"
>>>>> @@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=3D" \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -serial mon:stdio \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -netdev user,id=3Dnet,hostfwd=3D=
tcp:127.0.0.1:22222-:22 \
>>>>> -=C2=A0=C2=A0=C2=A0 ${QEMU_EXTRA_ARGS}"
>>>>> +=C2=A0=C2=A0=C2=A0 "
>>>>> +
>>>>> +if [ "$TPM2_ENCRYPTION" =3D "true" ] && [ -x /usr/bin/swtpm ]; then
>>>>> +=C2=A0=C2=A0=C2=A0 swtpm_dir=3D"/tmp/qemu-swtpm"
>>>>> +=C2=A0=C2=A0=C2=A0 mkdir -p "${swtpm_dir}"
>>>>> +=C2=A0=C2=A0=C2=A0 rm "${swtpm_dir}"/*
>>>>
>>>> This kills the previous TPM state, preventing to power-cycle the VM. W=
e
>>>> rather need to persist it aside the disk image. I'm massaging the
>>>> script
>>>> in that direction.
>>>>
>>>
>>> This was for debugging purposes as the TPM is no longer accessible afte=
r
>>> a number of keys entered.
>>>
>>
>> At least it is possible to encrypt a new image using the TPM state of a
>> previous run, just tested. In which cases exactly does this issue hurt?
>=20
> After creating 8 keys/Images the 9th time you want to add a key to a new
> the TPM will throw a error.
>=20

So, every boot-strap of a new image will add one key, and that will
start to fail after the 8th time. Then we should purge the newly created
subfolder in deploydir when performing an image deployment.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


