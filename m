Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA12C47422
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 09:07:23 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.83])
 by mx.groups.io with SMTP id smtpd.web11.13168.1706173635697590651
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jan 2024 01:07:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S13XCV13;
 spf=pass (domain: siemens.com, ip: 40.107.13.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtMQOUMIWLUNL7xImtO8WjGAuF0jjhNm8+xjAJPY47Bqebu1zn36/W1k4W51rVIAGewZFZsIZZNcnsmJyUWjJ3QmmdNhG9B4rz3ZJdReOPRTXPv+eoSZo/7rf3sFH8EBdQUhHa9gulwvngDtlcRxQQ+hZr4Or2ybARGgVemD9sR+P0C1xfu1xxkEUtjTUgVbsZ5QTNd775DgZqTf3w+d/okM/J6OeMp1huMLvHBcDe60kgWhUJjGfta2aZmwRja+zdJyXhTyaserGAUgN1YsNDjpUSZsoJKp4X/9KrV6yoNIdw9SNdn6scJCYGNLJgLYOV/ZsCbnudeKkkS0eS+Kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2dZPrwsx6HaaSoT3Y1Ufwb1SHJacFGRvNLf9zgJctQ=;
 b=fcBVrN7GpCbfsTlGOYHxqbaMfjqk9i45ezHeh3qgjhqfzN/vOdUCW4Rg2STIlLEFZjCDCSvkH47fMhiqT8sxq3P3e1rKEQSJ1Ma3h43e+dirQHBSNRxu2sg8ktPrfr3Tdbw4H1zShgm1SivMXrQ07ooYRLrs01kndreqCE4qoRliSi1zLaKZTROSwgMKakERW+D6cv4glxOt6pe8oI3fVkC87LiS6mHrvHy4TkIYjNvpR7CDhfXATM61gYfCU8UFAXqS3BqKper4kN/VKxtc3ev3alKhQKMUl+EnGGRsNH7nrXso8z+YmxR7xfq3BVaq/LjLW8GPD9kkgI1RWm1GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2dZPrwsx6HaaSoT3Y1Ufwb1SHJacFGRvNLf9zgJctQ=;
 b=S13XCV13mfFFPaWR/gOP9xjMEpRuhxZRJyUFn7UURwmxeA7OvGSbInQfgVrgXqcdkTU9tYQWjDRByTPOqxBhwWIIijrVE4MkXAvz0g2kRFzpAE6lPfJtUHfueK2iSpJ8mXo2wEK3P/SpwrpFJI9FihuKUbWUIVogU2tThtPGIu+61aqHjoMZPPssczvPYNHJwhXkC4C7hZPMw7ftfzo3+v8cAXpW3NdPibQ1ZaghrAp+tr/Z4szrvNXmZdziBL2R4dkCW21D5LVDhZUFrkZAcrzK+JN8X7JszCQCjooQn58LQtStdwq7LhnKtnjAkEBMdh+2whRSYzd1yRWewdJlWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB5639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:07:08 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7202.031; Thu, 25 Jan 2024
 09:07:08 +0000
Message-ID: <627eb1ef-efb7-4709-b8cc-5e2f0f255fa2@siemens.com>
Date: Thu, 25 Jan 2024 10:07:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2] swupdate.bbclass: add script
 section to the swu file
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240124094502.293170-1-Quirin.Gylstorff@siemens.com>
 <5a8c9bfd1b5e2707e7ae9e290a7b28761ca15ea2.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <5a8c9bfd1b5e2707e7ae9e290a7b28761ca15ea2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAXPR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3d8979-5ae9-4a2d-e23a-08dc1d8501ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MbEGMbVi18zyQxy0h8XGsjzEHvoqo6VdICktZtY2zbDJSesj4HpY9ctYluoQAbYx2ImeR9/+7h+HjqjlqahFvVyoJmsvqQTGP6a6rFFjNyGwlPdJpo5oSuUV/aOEjIpPK9D8JiZ9vRZgmK+y8QGMRJH8pVIKqig467o214zdSg5VBlaHpTh25B95tbnSGaAV0S5yZnq/7Ry3YSfHPk2RcY8WKFj5siQDWoNxfY3ilD/mJ9KcEKtRczc7DnGQ0A7gLwALnBRfjhFfAQYQ92xZzXuzp7lyqZ0Q9Pub5Ax8kWH1h45pGK2o1wns8I1HxkHoRdjD2LzfEWVEsXsx0mX23CbLqxAYlQbCwisJguDMfiBZw1iTYQMLHiue4zFzd+rbugf0g6SneSvtQNEYLGVlzaFobt8cGXa46p0UviYrxvc4Tdit7bYBT/2aySAkNbmIaqRtc6/PQX0ofUTZzMShNXHJ3MXEIHKfzjDmnR8O6yXN2PB4wiBy1fch+ZPt7cKR0MVJQxB4LEqky2epXQEDJawdjEUjvijLqzeBlb31LFFOxonCkC4wsnFi1IvQlWGv147fchM//arRgzRNbdS0MD6GAcmXqVZOnJ+iALmWgJkW027KC6P2zo3gNkRfj+LKWtrgW2hs0vqQTyOOqxYEOxZ/7MGvAwsMiuH6jzzMBm4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(26005)(83380400001)(41300700001)(8936002)(8676002)(6486002)(478600001)(966005)(86362001)(110136005)(66556008)(66476007)(31696002)(66946007)(6636002)(316002)(5660300002)(6512007)(2616005)(36756003)(2906002)(53546011)(6506007)(6666004)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3BASjv66+z7Jq4v78/WSHMY/W7LL4y2y+UoPSs/BipcQLaKEjG8S3PDmZrZF?=
 =?us-ascii?Q?aTXuHYm0DwT6U1Z7OtSmbftZLwlb+gDVqgF1PBy0phAjB+La/vmTmGU6X5fS?=
 =?us-ascii?Q?+aYhT6wmozgBD+23lQk/JTueFIm86a6RK6XpMLIMN5pP3/rQYNOHN5Ve9GLc?=
 =?us-ascii?Q?Drmm2uVJ++i3rZ/vZsNX+yY9YMeEZOu+Z5xhrvtSJun01PtPURO/NrAL4DQ9?=
 =?us-ascii?Q?JlVMRlBh84wVvYlme0uvk+4As0cdu/TjL9Gix14J5SWYKaEb8xS5O6CRr3hO?=
 =?us-ascii?Q?YzmtH+Jh21WPag5E+vY0RGoCLb+7ZjFjMxfF5NxqTRKKM1E32crc1Y3xVqqm?=
 =?us-ascii?Q?aR92ksuvQ2eD2SpoDPETGZov79e2+wVzA5ekcffYiMQ0B80zd9QJRNKyG9/C?=
 =?us-ascii?Q?fcp/82dzeF421xh/UTT3yHWLPyxkHMGnOBk18Ur6u8S1+Ebk9wNJ0RzPKxhN?=
 =?us-ascii?Q?8SjJ0ElQAALF5e8dNXU70ufYteXaf4l14qk7h/tKb+YSOT3pqgkVG9+wE2Li?=
 =?us-ascii?Q?ngGwZWHp0eIYJSWFMmXJC14DUCFKaF4hZe4gBGv8y7W4fWxnQxrVDgPxR3Ut?=
 =?us-ascii?Q?NANU8QoykZN+MjeLUR4cqJQViNs7cNlBSkd/cFONeUKQ260V8tk5tmMi7Jl3?=
 =?us-ascii?Q?CiOvqzwsxSbv6IJW3U4mIOr/0NXnYMHUf0ItgAAX0Og3YOtp24k7clFFF6Jk?=
 =?us-ascii?Q?h2HLSVXPuEluWP49+EAcIPh82PCYDhzDnusVJ+7X6rB5XtDhRz+/pRiI1wvN?=
 =?us-ascii?Q?qxtEqGnsTRWG7xPB2CHNHIFIqioDwZu5tdz74GtlaOJu9Kb9n9Jqz0U6RrTH?=
 =?us-ascii?Q?joIpRdWMJwQ2zl//NIDbcLdoTabpqS59etPO8E6DzxxW+pyYw4IlsvGofMi3?=
 =?us-ascii?Q?DjBlFvwwOhCQs/A/DEq5I26xcpbvga/X40xokUh4jcYJFnPjfyw78kOfqItO?=
 =?us-ascii?Q?9KBEJRaVVlQENFl8MOnQ/elBQyLrN0LfdWSMba2LYo/taltNaZjc3H49SwzY?=
 =?us-ascii?Q?WJTBH3LFlDOHvUylfIx+Db9yH5GgiLb3j957nmOqWuOx5DhTZyw2J3DIqDGZ?=
 =?us-ascii?Q?d7GU+Ak4zsvSs8/HPZPyatyD7Bii1n7r37fKuld1ArPYtTPzdDzxQD2Kr3pX?=
 =?us-ascii?Q?UQV+WGNaaZD8II0zNGo7LZH61ngwC/odFJdVW/B9Z5gB24j+C06yvCEIvJ3x?=
 =?us-ascii?Q?HuMWe4j8QE3gAfeaKEIbC/d5NnnMkr2sVE8cwPWMeBrtwipbLOGkJxeOCM1R?=
 =?us-ascii?Q?Zc3RHiuvKi9AtWb0S2PCM4S7DiV4lR6S6iAxNonflTnJCgwrP3AwV+ixHuaJ?=
 =?us-ascii?Q?etR8U9zgA++fCwwpH85gCDA2He4IpH8KOpq2DxL0x2VEtbnI/0nEJVgLhxp+?=
 =?us-ascii?Q?DxJ9YaG2QwtwEs1wd+8YLhl3eDtCltvZxWcO671Jtm+nxshz7qNAFVMCeNLE?=
 =?us-ascii?Q?wloZVQIvfKRRs0UOon+6MNCR5LWC7mIlsRaIaVPn15XTLZIxcTIzXsFwcl9f?=
 =?us-ascii?Q?mBCjduqR2RRAHdpzdDot6xLCBwho8NgKVT680tQJf7d4vTSQEZdzvPurfwGj?=
 =?us-ascii?Q?Qt+8iwAe5PdLGwPGVLobcjfWNBssJSUwEhU3EZZctm+zQuPJLJ6oYMqIdsJt?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3d8979-5ae9-4a2d-e23a-08dc1d8501ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:07:08.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcJlm2Mz8FuUvv+FN869gOboimxQVwEuvHd3bh5+av/ysXdLU5R3OuAr1Sg5zVu0n7kApa2EGyo/FsDdAvDV0x0w32ZtlYcBelRwBJ1dPB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5639
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jan 2024 09:07:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14456



On 1/25/24 09:43, Moessbauer, Felix (T CED OES-DE) wrote:
> On Wed, 2024-01-24 at 10:44 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows the user to add scripts[1] to the swu file by
>> setting the variable `SWU_SCRIPTS`. Scripts can be used to
>> prepare the system for an update.
>>
>> ```
>> SWU_SCRIPTS =3D "<script_file_name>@<script_type>@<optional_data>"
>> ```
>> This will add=C2=A0 `file://<script_file_name>` to the variable `SRC_URI=
`
>> and
>> `<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description
>> will contain
>> the following section:
>> ```
>>  =C2=A0=C2=A0=C2=A0 scripts: (
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "<s=
cript_file_name>";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "<scrip=
t_type>";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D "<optio=
nal_data>";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "<sha=
256 of postinstall.sh>";
>=20
> ---------------------------------^
> shouldn't that be sha256 of <script_file_name> ?

copy paste from the readme.
>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },):
>> ```
>>
>> [1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> Changes v2:
>>  =C2=A0- change seperator from `:` to `@` as it already used for the
>>  =C2=A0=C2=A0 configfilecheck
>>  =C2=A0- add optional data entry
>>  =C2=A0- add warning if less then 2 parameters are given for entry
>>
>>  =C2=A0classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 37
>> +++++++++++++++++++++
>>  =C2=A0doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 30 +++++++++++++++++
>>  =C2=A0recipes-core/images/swu/sw-description.tmpl |=C2=A0 1 +
>>  =C2=A03 files changed, 68 insertions(+)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 8f1215d..256a60f 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -58,6 +58,7 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_NAME \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>> +=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 "
>>  =20
>>  =C2=A0# Add the bootloader file
>> @@ -123,6 +124,42 @@ python add_ebg_update(){
>>  =C2=A0=C2=A0=C2=A0 d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_l=
oader_file)
>>  =C2=A0}
>>  =20
>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_scripts"
>> +python add_scripts(){
>> +=C2=A0=C2=A0=C2=A0 swu_scripts =3D d.getVar('SWU_SCRIPTS')
>> +=C2=A0=C2=A0=C2=A0 if not swu_scripts:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>> +=C2=A0=C2=A0=C2=A0 swu_script_entries =3D [ s for s in swu_scripts.spli=
t() ]
>> +=C2=A0=C2=A0=C2=A0 script_node_list =3D []
>> +=C2=A0=C2=A0=C2=A0 for entry in swu_script_entries:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_elems =3D entry.split=
('@')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(script_elems) < 2:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.w=
arn(f"SWU_SCRIPTS entry:'{entry}' is missing
>> elements.")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_file =3D script_elems=
[0]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_type =3D script_elems=
[1]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_data =3D None
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(script_elems) > 2:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scri=
pt_data =3D script_elems[2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node =3D f"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "{s=
cript_file}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "{scrip=
t_type}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if script_data:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
 +=3D f"""=C2=A0 data =3D "{script_data}";"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node +=3D f"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "{scr=
ipt_file}-sha256";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }}"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script_node_list.append(node=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_ADDITIONAL_=
FILES', " " + script_file)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SRC_URI', f" fi=
le://{script_file}")
>> +
>> +=C2=A0=C2=A0=C2=A0 swu_scripts_node =3D "scripts: (" + ','.join([n for =
n in
>> script_node_list]) + ");"
>> +=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>> +}
>> +
>>  =C2=A0# convert between swupdate compressor name and imagetype extensio=
n
>>  =C2=A0def get_swu_compression_type(d):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYPE')
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> index 1c94699..b393caa 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -21,6 +21,36 @@ window is still possible.
>>  =C2=A0If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is al=
so
>> stored in
>>  =C2=A0the `*.swu` file.
>>  =20
>> +## SWUpdate scripts
>> +
>> +It is possible to add
>> [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scri
>> pts) to a swu file.
>> +
>> +To add a script entry in isar-cip-core set the variable
>> `SWU_SCRIPTS`.
>> +The content of the variable has the following pattern:
>> +`<script_file_name>@<script_type>@<optional_data>`
>> +
>> +The file referenced by `<script_file_name>` is added to the
>> variables `SRC_URI`
>> +and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a
>> `FILESPATH`
>> +location.
>> +
>> +Example:
>> +
>> +```
>> +SWU_SCRIPTS =3D "postinstall.sh@postinstall@some_data"
>> +```
>> +This will add=C2=A0 `file://postinstall.sh`=C2=A0to the variable `SRC_U=
RI` and
>> +`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will
>> contain
>=20
> How about the lua scripts, where the preinst / postinst are just
> functions within a single script? Could you please also give an example
> regarding how to specify that.
>

This would be

```
SWU_SCRIPTS =3D "installscript.lua@lua@some_data"
```

and the installscript contains:

```
function preinst()

end

function postinst()

end
```=09

I can add the script to `recipes-core/images/swu/` if this helps, but=20
currently we have no functionality in cip-core.

Quirin

> Felix
>=20
>> +the following section:
>> +```
>> +=C2=A0=C2=A0=C2=A0 scripts: (
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filename =3D "po=
stinstall.sh";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "postin=
stall";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D "some_d=
ata"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D "<sha=
256 of postinstall.sh>";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },):
>> +```
>> +
>>  =C2=A0# Building and testing the CIP Core image
>>  =20
>>  =C2=A0Set up `kas-container` as described in the [top-level
>> README](../README.md).
>> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-
>> core/images/swu/sw-description.tmpl
>> index c52372c..88cb475 100644
>> --- a/recipes-core/images/swu/sw-description.tmpl
>> +++ b/recipes-core/images/swu/sw-description.tmpl
>> @@ -35,4 +35,5 @@ software =3D
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 };
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sha256 =3D "linux.efi-sha256";
>>  =C2=A0=C2=A0=C2=A0=C2=A0 }${SWU_FILE_NODES});
>> +=C2=A0=C2=A0=C2=A0 ${SWU_SCRIPTS_NODE}
>>  =C2=A0}
>=20

