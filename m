Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1768BECAAA1
	for <webhook@archiver.kernel.org>; Tue, 30 Aug 2022 18:10:16 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.71])
 by mx.groups.io with SMTP id smtpd.web12.15375.1661883007051919362
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Aug 2022 11:10:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HXrpn7Q5;
 spf=pass (domain: siemens.com, ip: 40.107.8.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBl3Fcc8tbHSvokxPvC1iUabyccxmHZqks6DUSez/GJh/MFn80vUXzyTQZErQmqXfyMJaapNQEgMLBMTYsL5IuTf/WHJ4LC2CDpXAjFBG1m2iUx+TmeOIq6PNcxz/LbWJDT/bi8DWHHri6mcxwaWaXeqoC2S1Ony55z4iscrBcGVt6m1BIDQaJAN6uA/CWD2/IKqsQzbKTpTCfsYmTRi8j7AMYDLc75TrVbBkUxTfNoHResj/BKC8x7ukVXwzHukVrqqTn4h0FhAx8KCYGzl1CEYP3Hewow6oK1OlF/mQKFLbJLisQ6CNtxlDighFUYfuVilZDTY1Ve6EMddTcEydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orxhpR4IwqDuhoenoluXEDCaUMZSYclcQsn4BprIioE=;
 b=cURA0hfhJADrDt9e4yNX2WJX+Nyu5D9QkWiguJFE7ebRXzQe5TLjTucEjvmPqXpNTFYifXlLG2SPyzdp0pTIfHFdHhk9WI7q+GIIJEPg43hApu5RH5k72+pjPLAo84/kpxIcnSH4YQp17t47WG2esxABDB1cs+xnpfWtRUSqVuKaMLM0+kzMb0vkli2VyQlBLm7PzLjAJugm3IMlVM07aTzyHt7QqWlx9GI/gxTL7qlA99RYdxq9yHqreMJzfKT/mew1KYtY7q+BQfY3M/DZ1sQi8vCEcE7H3G1qwIUprIZ6WgkS43+od3qF9rOWoOkgOiVs27n/3+LpsMw5jz9oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orxhpR4IwqDuhoenoluXEDCaUMZSYclcQsn4BprIioE=;
 b=HXrpn7Q53BHJ5/+1YP9VJdBZMsL59ezju9FW2KRMyuEqrzwxCyfMdyloAbV01s4I3btWXzbUT1TeGy+39aJr5wHvgzV9JrHi83jasKEyU8fG1NKybcSzisjfeZkiYOEaGu9OFRPZ6w9Zrfh/Is977Q+cqlK7JEqszyn6Pw+HFChvoMw+CK/71l0gNVMvjSomk4CxSG+sJkongG1coaLojdG6BJGe8+oPpcPIkOKZnCag5rrc7oCkTu/eDly5M5olATng4dNbsvHmkrJNvzOf6kh/1lKeenxEB9RQ0N8UGsWYg5FGftbyxbzNBaa8H2+EcMkztZoBTSljtlgK0NmHwQ==
Received: from AS9PR06CA0456.eurprd06.prod.outlook.com (2603:10a6:20b:49a::11)
 by DB4PR10MB6238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:10:03 +0000
Received: from VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:49a:cafe::f1) by AS9PR06CA0456.outlook.office365.com
 (2603:10a6:20b:49a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT089.mail.protection.outlook.com (10.152.3.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 18:10:02 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 30 Aug 2022 20:10:01 +0200
Received: from [139.22.105.140] (139.22.105.140) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 30 Aug 2022 20:10:00 +0200
Message-ID: <413a9233-9dae-e950-1c6e-f73bec007ae8@siemens.com>
Date: Tue, 30 Aug 2022 20:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core 0/4] SWUpdate on BBB
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <e796fcf5-7654-13fd-8001-71fa611398e0@siemens.com>
 <OS0PR01MB6147702A4B04BA048D29FD9BC7799@OS0PR01MB6147.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OS0PR01MB6147702A4B04BA048D29FD9BC7799@OS0PR01MB6147.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.105.140]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.606900-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSzO278aZjZxZ8c50LsMZjCp/k5m7D0YTS/x5KZMlKYS/a5B
	oXfdPww+9dpydf/0bbBnbyATPFLi0kBmmtT84w8xwwKeumMCKVg1mB4DwaTV1oh/ebSxR/HnqUd
	pDBnLMO2P+SOe8+ariPtqIrkO/l5cQ+c+BLvBk6zCHctFHXKjJI+eiI05y0fpf8dNT84FpMateS
	443ymeUfh8FcXE0B+nMiy+aPgxOwdwZ1SEiBJsNQ8cfGbcsHDULJEcjZifhq5eYVWU5uHQ/EF+Q
	lYpjQppCtWCkj21FWSjxYyRBa/qJQPTK4qtAgwIPcCXjNqUmkUgBwKKRHe+r4NydIhiiwUJuFF1
	qPPDG1eC5ibx4N8TBYFfjdVkoqAt8+WjH8goXV4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.606900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6458A97C8DB8E02816EE080381A83A1E1C386B30F84FF1436A8820155CA50A6A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ed3330-8977-4981-c031-08da8ab2dbac
X-MS-TrafficTypeDiagnostic: DB4PR10MB6238:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XexJn2arqlwlfcL2ZiC/YmHWfLFUSVlwnCB+ic9XQZYX6Sve2FGLHLtiqZmiyTHnwB09K0iH5JKC7zdrafPtOGUwbZYyAfAPkym9wd2Cd3WTj2y8Qiwjq7/lEUiFbhOLH22mimLi/jMwPE2TI2o3W0SyXbgRxQxZuhRYtZtIYdI+hRIc9Mq4DOOhwUP2sEWWbcEaX1g3iT3WU4EgFCJZJuRga6+bamWX8IJyXRcY37mXyOMVCR8NBfwIHY1ivcSvV2MbRMV6dOcYud3heaSskIwkk3TxgPRg0p2+Omi4POVdK55jQ4DCkFfMUNLwu2b2NLz2Y7+hJXdw+fid+A9Wxmc+WiYFZe8SYxzm9WsNoiBOQhBf5yruiPNx28Zgjdo9AkU4MnoLLthNL7xHAIGWbkF4yeT0UsRAzvihz9t6ddkFZqDlrou56VkGlx7LU1+rS+zrUPTX0luu2uv/mTAAuQ2T2CYWF7se0nmdr+2OocN/7Pv3pI6eeushN16LSLu/fH8QzoKh3siQQBpjo7rq+YSe3DLflEbQVcpy3mxsxcccG8glDSaALg0xsHXT58ANZ8AyL7HQgEnWCEfJ8/DBC+NAdX05OhTewrqjVyBU4orUfNeTNHplqb3KLSffdHNqMyZ3QHJOhGTVierIJoIy7tda87QSR2gIvdD2ZUm/d3i4egyipOw0kooiR5GuQjWa3LQIIH2l7OkwMY7WjOeWWJ6sj+RnKRx7/SsATcp6xGj3QWh9evWNq/ezqy4cdPFLjEQzBuCc7DYWdGcmt9fv7gpDhqBTncTZ78ltohe8TJ7CW6lipFYOp1UTVdW9UYE7Sa9S8KwtLODLFQUiGT+EdqYBjXLjB/E+n8215xLZ8ksBSit4Awu5I3R3O/rYdbpwoBgDCHH+60VOB3s1hXsoAg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(8676002)(31686004)(54906003)(16576012)(4326008)(110136005)(31696002)(966005)(316002)(70206006)(70586007)(8936002)(478600001)(6706004)(5660300002)(41300700001)(81166007)(82960400001)(356005)(36756003)(86362001)(956004)(2616005)(53546011)(83380400001)(2906002)(336012)(26005)(82740400003)(82310400005)(44832011)(47076005)(36860700001)(40460700003)(40480700001)(186003)(16526019)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:10:02.0065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 19ed3330-8977-4981-c031-08da8ab2dbac
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6238
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Aug 2022 18:10:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9326

Hi Shivanand,

On 30.08.22 09:13, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hello Jan, 
>   
> Sorry for the late reply.
>  
>  >  Why not using the UEFI path, like we have for qemu-arm already? Would be much simpler to add (and likely also to maintain).
>  
>  I don't have experience on using UEFI. I'll check the current implementation for qemu-arm and will try to use UEFI path for  BBB. I also created issue [1] in isar-cip-core to discuss SWUpdate on BBB.
> 
>  > Also, I'm skeptical that your changes didn't break the UEFI integration.
>  > Did you test it afterward? 
>  
>  It is tested only for BBB SWUpdate. I'll check and update the patches such that they shouldn't break UEFI integration.
>  
>  [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/39 
> 

I've hacked up a version that boots the BBB in UEFI mode and uses the
same pattern that we have for qemu-arm. But I still need to convert that
into commits and send patches to the list. Will do that next days, then
we can discuss the pros and cons.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

