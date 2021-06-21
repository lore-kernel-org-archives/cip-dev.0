Return-Path: <SRS0=tTCo=LP=lists.cip-project.org=bounce+64572+6544+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053EAC48BE5
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 06:43:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468456102A
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 06:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468456102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6544+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AUPPYY4521723xYvLLIrSE9k; Sun, 20 Jun 2021 23:43:28 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web12.43569.1624257806201117782
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Jun 2021 23:43:27 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id VPmN14873A;
	Mon, 21 Jun 2021 15:38:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQD29IxrWpYwbna+WWcK9ZIbVXev3t1+4Ro4RiNDIsc6NmeswR9gH2+t2wUknp9Cq5kjLm36x6HidB8oOKR/nMjuvDcElcwfBkZv/VJT8fnEA3JtAHIPY9BxbakD1yr19pIRVsT8ZPQ1/Hh36/cMeP8XVFWnXOXw6bfCsnbAnSAsTzXvmqYw3OPLi6GCf987CGp3LPvyGQwVwBG8c/OEQHifa2DIqNpfLQhLiIiIhKhrzcMm3qJCeb5nATAcvXpPDTutqre21ZI226O8AXYGEcNLNHa14YTQbahNTbOC5jWYAidAn2ED3QC0c34eoNTlU4Kadgz4zRpqSvPcF9Jaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8nN/7AHASDxTcFPEBppf9Ds1dzCQtTz8Jl6YBAo33s=;
 b=i3S86O4eI1l2MesU+jS85IyNLCLw6uNbBBpCcm7x1exsvoWqR4K3SJZphBBdeQFpaMVZhc+Zqus9ymSb12tRM7dpQZ2tbaunbKXLBnYaZsknUq5gfCi+7v6Nf/RWJuUBwh0/WcOD1P1ukNrVavU5qU5lyz4mo1R0e5xeUlWNxQxjqpuzOfVyIBcOd0NjoMT6knWDAysk8Ygydtc9UrcwC1auGCR9n7Y6+fuzA3wwMJ6b9F8cQG3pSDjTEvdFk1HhzB5kj2sjfq5n38cSBVrVgpkz/x/hqUKuCwd7wAgA116Y/627d8igYKu9RsJ0GXf9mVHTCFCT3eEERMMfzuduMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSAPR01MB2722.jpnprd01.prod.outlook.com (2603:1096:604:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 06:37:57 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::51f5:d598:855d:a1cc]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::51f5:d598:855d:a1cc%4]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 06:37:57 +0000
X-Gm-Message-State: TUCGRhGMTpITpgkEpgya5pabx4520388AA=
X-Google-Smtp-Source: ABdhPJw8jSdM8MW2nYjRu/WKj8j6HJ58BTBuwfaZLWOb7NTKiTdYhWe5a+TLG4hUg3eQnpLZMKR7QePudLjr1UxoiRk=
X-Received: by 2002:adf:e50b:: with SMTP id j11mr25778392wrm.377.1624257467513;
 Sun, 20 Jun 2021 23:37:47 -0700 (PDT)
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Mon, 21 Jun 2021 15:43:17 +0900
X-Gmail-Original-Message-ID: <CADPJy8XpMaqq+PsX=LmZJzmsu0o3Rus=_Tho6F684M_LbtMbjg@mail.gmail.com>
Message-ID: <CADPJy8XpMaqq+PsX=LmZJzmsu0o3Rus=_Tho6F684M_LbtMbjg@mail.gmail.com>
Subject: [cip-dev] lab-cip-cybertrust will be temporarily offline
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, hws@denx.de, Smita_Gumansingh@mentor.com, 
	pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp
X-Originating-IP: [209.85.221.48]
X-ClientProxiedBy: AM0P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::13) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-wr1-f48.google.com (209.85.221.48) by AM0P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 06:37:56 +0000
X-Received: by mail-wr1-f48.google.com with SMTP id j1so1024601wrn.9        ; Sun, 20 Jun 2021 23:37:56 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4871cf-f5f7-4991-f76a-08d9347f1aee
X-MS-TrafficTypeDiagnostic: OSAPR01MB2722:
X-Microsoft-Antispam-PRVS: 
	<OSAPR01MB27228D17643C7DDBCB512405BD0A9@OSAPR01MB2722.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	AWAbw+v2WU69nGyuQA+JqNwQ76OENSnuX+zBw3k51y3Odpk2DWVX8G7lw02OLP4hiEOHBiKRDFwti4NqQyWL0XUxvKM1Ri9zDLALTBSjaViLJedNYsv1R6Gu59IpLfEkHjIAtnyEokZYrz/9Uz5yjGAgdqUoZ+bAEQ+6F+i1eCtbz5oZqRNOR7g4GA1HlIvT2zr+lfLBIfuttIBy9AozgIOIlXZNItyrTnUnY3zDG1rvK+S1TB1kXbrqSH/uv3DBeeKEBvAyRw9FdNMQT6o7F2+Tf4Cw/HElyTZWn9Li6sLfk5MHiBScMjD1fkKn+LjSbCqCNyQ0HDXHk8Q+cnCEkDKtqdNmivUys3uzI2gUXvUPGGgBlQFubnA8kQmyUQAgZrNAStnzg/qHijaQZkbI0ayT8OHKVgsfA1zRQDyVW8qkl35WrISMaRLfiAT4RzJ1KUk2qXW9pr+r8rz9XI4RKA2L2VaRKpx+ZRjveQFDpU9yqZFPkdIvHohhw3fdQQoFHQb/8+tM/DhklIcUF+bRhuYTo1w2ZkS3W6d75jeVEL8RpVqcoGXAqTWge6uRLLcKfpGcjsd8qBYhTnAd2Rp6oAaFtNuCTqk+ydsKpuD5AwjpBXuDSVYwELoADOn1fe7PrpbgQtoCYHzi3K0j1SXOoI2gASRtGtan3wbdaz3+Q1I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SS9LanBRUFhBY1p2WkRYVDQ0YzhFbkkzMGJTeTBWTHlaWFQzamZKY2dKNzZk?=
 =?utf-8?B?aVVJdzB6NFRRQy96THZ2YldSNDFoUjhDVldFTTNQNUVlTGFFWmhaM0E3RlFW?=
 =?utf-8?B?SUI3Q2xKaTZySlNQM2xLOUM1OFZOTFoxenQ4MURKN3JiNHNUVnArVXJ6VGRn?=
 =?utf-8?B?d1FPTmJjY2VHVVZkdjRVQjdVRU5kdlZyVTZIZnNoQ0F1dDVUUWorUG0yQUd1?=
 =?utf-8?B?RHNOOWdlUzVkT0Uvb0Zza2pkZklzNmsySHJmdVhsQzVjWXB1Mi9SSVNJVFlz?=
 =?utf-8?B?NFZvOHZ1QXUxZ3dBc3pBNmh6ZGl3SWtic0xDeVdVTWNYZXNnNjczdmZQS0k1?=
 =?utf-8?B?ejBtSVpGVStHZXBVdXhhUTd5OFZRaUdDOXNHc0x0TmNZZ0o4MXBLclN4S0NL?=
 =?utf-8?B?Qys2bEJheXFHK0kwS1ByTkgxeHZnalJXN0l2RlRhSko5TDkvZ1puL3ZVWWZN?=
 =?utf-8?B?d2wwUEtlVnVhbGdPRVFjVlhwcXNadHVIYndESlluVi9JZjJRMzZFREhIblBr?=
 =?utf-8?B?TE5mLzZ2aFpnSS9uak1rZ0RlSmpwazdUakg5L0p6VkJwSlgvZHVLU3ZhcUs5?=
 =?utf-8?B?MStueE1XR1M3ZUNZMXpSNzV5b2tZNVZzc0FXRjVOU21zR2FLMnpKdlc3T1Zm?=
 =?utf-8?B?OTdZQ0EvZ2tUclhuSis2VEswdzBJd0hVRzMyREd4elhqOWV6SFlUZGViRmd3?=
 =?utf-8?B?eitnMmkzZnVOaTEySHRlZDdxNlMrc1M4NEZIc3MyeEJFTm94TXZ6WlFQMU5j?=
 =?utf-8?B?aXhrZDVOQ1NEb1lQbGQvc2E3S3Z5TlVra3hjY2ZrVzhsWnc5V0tKVktIOUZ2?=
 =?utf-8?B?SCtaMFNwMUpvQ2VPbEprVm5RdTNpcldmZ0V0ckh5RCt1WTM5WkRxbnB2TjZE?=
 =?utf-8?B?WWVSR284bHRPQkVoYjBoUHIyR0dkb1RtUnhOVlR1cnlGenl0TFYzSERTTStI?=
 =?utf-8?B?cWhIaTlHbW1vSDk1U1ZOeVdoVlBPT1NHc0ZuUGZ1NVRyRG4vbzRmUVZjOUpq?=
 =?utf-8?B?cFA0aW42U2E5Nk92REhXb3lGU3pZVFA1SFR1N0piMTNUNXdRdFcrWmxLdnB2?=
 =?utf-8?B?OUlCSm1zcGdPSE1oNUhFbS9JWm5MRUtBcEovRkJhMHY3OTFhbk9BTjhDdkFU?=
 =?utf-8?B?ZkE2RUJNaisvTFdmVExpTXI3TUtlMXEyOEdNVXFzNGVtUmhjSjJmV0RITFdD?=
 =?utf-8?B?bm51OHJIT2liL01oQ2t0ZkFwUkIxaTJlSlhJSnkrOGk5a3dtZVU1aGlmVjBw?=
 =?utf-8?B?cnFjWmJxOURqOFIxMEgrRk5Lc0VsOVcvdWtpejdXTDA1OWc0cjQyY1c0UjZI?=
 =?utf-8?B?dUllMmtCeEUwSkh4clJsdUw2RmIraDhUcEJtUHVxRVE4dzBSQitkUWRIamhl?=
 =?utf-8?B?RzNxR3BacEV4UzlmYWwxRlpERXM5aWtZQkR4SEtSQlptZS8wU2lFU1FYK085?=
 =?utf-8?B?blpMdGxsSG9aYUVEc2NIM09GUS9IRldWWVJDb2M1QzA1c21aWHh4elVpZVo1?=
 =?utf-8?B?ZDZuano4akM3UHBvUE9lQXhCb2hBVVBHeVhkdUVrbk5pTVE4b01DNGpYTmdR?=
 =?utf-8?B?bDVsekp2Zk1jeVVXcUhIUUFaeE8vM1k2Snl1dEovK1hEREEzZWoyVEFaS2Y0?=
 =?utf-8?B?R1FaTWJqenZ4bllGSmRhUUN0ZGJ1TjZrNjJnWTJaNWlUM1grajl6ZHNzVjlI?=
 =?utf-8?B?MVErS3Jib29veDBHWVpySUM3eWxKL2g4NVFhWS9Xc2VUL0ZHV1ZnMWRMSkNK?=
 =?utf-8?Q?q3pMi8emTAC096HJzF2sFQEwhFLYXeEL0MK+r6n?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4871cf-f5f7-4991-f76a-08d9347f1aee
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 06:37:57.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaooRuNKCNPWMNlaSO5kZYSHl01F0SZy0kELQXQU4y7Hi/pUI7o9Ra+CzjI3+LfJB+pxtO/+AHg2a5r19fFqsr/NCMLbjH0haIW3dcWSO08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2722
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="AVghHjXIJtyZP3TYqySb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624257808;
 bh=Gg78MAUgkjSPQH3ObJ3XhWgMVy7K4DHj9t5gVg2nZT4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BROPdoIdmzlxQJsppC7ittcvYS78yrv+vEJ1WnTCuSEqhbx5AKjEwUVNbv8KBzsrRAN
 BFNcjSta6fZKKgxh/ovTNAX+/H9rrwGhBNJ3RFCKRwGlM+sViLdlbTViYbUUqHKSON1VN
 qaxK9K2YRoU1dBM/MaBf+2AKkGL3vQb7UkQ=

--AVghHjXIJtyZP3TYqySb
Content-Type: text/plain; charset="UTF-8"

Hi.

The lab-cip-cybertrust will be temporarily offline on June 25th due to physical
location change. I'm sorry for the inconvenience.

The schedule is as follows:

June 24th (Thu.) 10:00- (UTC)
- zcu102-02 and bbb-03 will be changed to offline.
- zcu102-01 will be still online.

June 25th (Fri.) 01:00- (UTC)
- zcu102-01 will be changed to offline.
- lab-cip-cybertrust will be changed to offline.

June 25th (Fri.) -10:00 (UTC)
- lab-cip-cybertrust will be changed to online.
- zcu102-01 will be changed to online first.
- zcu102-02 and bbb-03 will be changed to online following zcu102-01
(within a day).

Best regards,
-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--AVghHjXIJtyZP3TYqySb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6544): https://lists.cip-project.org/g/cip-dev/message=
/6544
Mute This Topic: https://lists.cip-project.org/mt/83683050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AVghHjXIJtyZP3TYqySb--
