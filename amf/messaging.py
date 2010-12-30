# vim: fileencoding=utf8
import datetime
import time


class AbstractMessage(object):
    """
    すべてのメッセージの抽象基本クラス。 メッセージには、2 つのカスタマイズ可能なセクション（ヘッダーおよび本文）があります。 headers プロパティは、特定のメッセージインスタンスの特化したメタ情報へのアクセスを提供します。 headers プロパティは、固有のヘッダー名をキーとして持つ結合配列です。 

    メッセージの本文には、リモート宛先によって配信および処理される必要があるインスタンス固有のデータが含まれます。 body はオブジェクトで、メッセージのペイロードとなります。 
    """

    # サーバーからプッシュされたメッセージがバッチとして到着したとき、そのバッチ内のメッセージが複数の異なるコンシューマインスタンスをターゲットにしている可能性があります。
    DESTINATION_CLIENT_ID_HEADER = "DSDstClientId"

    # メッセージには、メッセージが送信されるチャンネルのエンドポイント ID のタグが付与されます。
    ENDPOINT_HEADER = "DSEndpoint"

    # サーバーによってグローバル FlexClient の ID 値が出力メッセージに割り当てられると、このヘッダーはその値の伝達に使用されます。
    FLEX_CLIENT_ID_HEADER = "DSId"

    # 宛先のリモート証明書を設定する必要があるメッセージは、このヘッダを使用して、資格情報ストリングの作成に使用された文字セットエンコーディングも報告する必要があります。
    REMOTE_CREDENTIALS_CHARSET_HEADERg = "DSRemoteCredentialsCharset"

    # 宛先のリモート証明書を設定する必要があるメッセージは、このヘッダー内に Base64 エンコードされた資格情報を保持します。
    REMOTE_CREDENTIALS_HEADERg = "DSRemoteCredentials"

    # このヘッダーは、要求タイムアウトを定義して送信されるメッセージに使用されます。 
    REQUEST_TIMEOUT_HEADERg = "DSRequestTimeout"

    def __init__(self, *args, **kwargs):
        self.messageId = kwargs.get('messageId', None) # TODO ランダム
        self.clientId = kwargs.get('clientId', None) # TODO ランダム
        self.destination = kwargs.get('destination', '')
        self.timeToLive = kwargs.get('timeToLive', 0)
        self.timestamp = kwargs.get('timestamp', time.mktime(datetime.datetime.now().timetuple())*1000)
        self.body = kwargs.get('body', {})
        self.headers = kwargs.get('headers', {})


class AsyncMessage(AbstractMessage):
    """
    AsyncMessage は、すべての非同期メッセージの基本クラスです。 
    
    メッセージの相関 ID へのアクセスを提供します。 メッセージの応答と分割に使用されます。 correlationId には、このメッセージが参照する前のメッセージの messageId が含まれます。 
    """

    # subtopic プロパティが定義された MessageAgent から送信されたメッセージでは、メッセージのターゲットとなるサブトピックがこのヘッダ内に示されます。
    SUBTOPIC_HEADER = "DSSubtopic"

    def __init__(self, *args, **kwargs):
        AbstractMessage.__init__(self, *args, **kwargs)
        self.correlationId = kwargs.get('correlationId', '')


class AcknowledgeMessage(AsyncMessage):
    """
    AcknowledgeMessage では、先に送信されたメッセージの受信を確認します。 メッセージングシステム内で送信されたすべてのメッセージは、応答を受信する必要があります。 
    """

    # エラーヒントヘッダーのヘッダー名。
    ERROR_HINT_HEADER = "DSErrorHint"


class ErrorMessage(AcknowledgeMessage):
    """
    ErrorMessage クラスは、メッセージングシステム内でエラーを報告するときに使用されます。 エラーメッセージは、システム内部で送信されたメッセージのみに応答して生成されます。 
    """

    # メッセージが配信されていない場合は、faultCode にこの定数が含まれます。
    MESSAGE_DELIVERY_IN_DOUBT = "Client.Error.DeliveryInDoubt"

    # 再試行可能ヒントヘッダーのヘッダー名。
    RETRYABLE_HINT_HEADER = "DSRetryableErrorHint"

    def __init__(self, *args, **kwargs):
        AcknowledgeMessage.__init__(self, *args, **kwargs)
        self.extendedData = kwargs.get('extendedData', {}) # クライアントでのカスタムエラー処理を容易にするために、リモート宛先でこのエラーに関連付けた拡張データです。 
        self.faultCode = kwargs.get('faultCode', '') # エラーに対応するフォルトコードです。 この値は通常、表記 "[outer_context].[inner_context].[issue]" に従います。 例えば、"Channel.Connect.Failed"、"Server.Call.Failed" などです。
        self.faultDetail = kwargs.get('faultDetail', '') # エラーの原因についての詳しい説明。 これは通常、リモート宛先からのスタックトレースです。 
        self.faultString = kwargs.get('faultString', '') # エラーについての簡単な説明。
        self.rootCause = kwargs.get('rootCause', {}) # エラーの根本的な原因がある場合は、このプロパティにその詳細が含まれます。 これは ErrorMessage、NetStatusEvent 情報オブジェクトまたは基になる Flash エラーイベント（ErrorEvent、IOErrorEvent または SecurityErrorEvent）の場合があります。 


class CommandMessage(AsyncMessage):
    """
    CommandMessage クラスは、サーバーインフラストラクチャにコマンドを送信するためのメカニズムを提供します。対象となるのは、メッセージングのパブリッシュ/サブスクライブ、ping 操作、クラスタ操作などに関連するコマンドです。 
    """

    # 既存のサブスクリプションのセットに追加するサブトピックとセレクタのペアの配列を指定するために、MULTI_SUBSCRIBE メッセージ内で使用されるヘッダーです。
    ADD_SUBSCRIPTIONS = "DSAddSub"

    # 認証コマンドに対応するサーバーメッセージのタイプです。
    AUTHENTICATION_MESSAGE_REF_TYPE = "flex.messaging.messages.AuthenticationMessage"

    # この操作は、現在のチャンネルを通じたリモートエンドポイントへの接続をテストするために使用します。
    CLIENT_PING_OPERATION = 5

    # この操作は、クライアントが発行したポーリングコマンドの結果として、失われたメッセージまたはキャッシュに入れられたメッセージをクライアントに同期するためにリモート宛先が使用します。
    CLIENT_SYNC_OPERATION = 4

    # この操作は、クラスタメンバーシップに基づいてリモート宛先のフェイルオーバーエンドポイント URI の一覧を要求するために使用します。
    CLUSTER_REQUEST_OPERATION = 7

    # この操作は、チャンネルが切断されたことを示すために使用されます。
    DISCONNECT_OPERATION = 12

    # この操作は、ユーザーが現在のチャンネルにログインできるように、エンドポイントに証明書を送信するために使用されます。
    LOGIN_OPERATION = 8

    # この操作は、ユーザーを現在のチャンネルからログアウトするために使用され、チャンネルが HTTP ベースの場合にサーバーセッションを無効にします。
    LOGOUT_OPERATION = 9

    # エンドポイントは、最初の ping CommandMessage のハンドシェイク中に利用可能な最新のメッセージングをレポートすることにより、サポート対象の機能を示唆することができます。
    MESSAGING_VERSION = "DSMessagingVersion"

    # MultiTopicConsumer が、同一メッセージ内の複数のトピックをサブスクライブまたはサブスクライブ解除するために使用します。
    MULTI_SUBSCRIBE_OPERATION = 11

    # サーバーからの設定がチャンネルに必要であることを示すヘッダーです。
    NEEDS_CONFIG_HEADER = "DSNeedsConfig"

    # ポーリング応答の処理を抑制するためのヘッダーです。
    NO_OP_POLL_HEADER = "DSNoOpPoll"

    # この操作は、リモート宛先で保留されている未送信のメッセージをポーリングするために使用されます。
    POLL_OPERATION = 2

    # 次のクライアントポーリング要求までのアイドル状態の待機時間を制御するヘッダーです。
    POLL_WAIT_HEADER = "DSPollWait"

    # サブスクライブを解除するメッセージのヘッダーでこのパラメータが true に設定されている場合、持続性のある JMS サブスクリプションは維持されます。
    PRESERVE_DURABLE_HEADER = "DSPreserveDurable"

    # 上記と同様。ただし、削除するサブトピックとセレクタの配列を指定します。
    REMOVE_SUBSCRIPTIONS = "DSRemSub"

    # コンシューマによって発行されたサブスクライブコマンドでは、このヘッダでコンシューマの selector 式を渡します。
    SELECTOR_HEADER = "DSSelector"

    # この操作は、リモート宛先にサブスクライブするために使用されます。
    SUBSCRIBE_OPERATION = 0

    # この操作は、リモート宛先によるクライアントのサブスクリプションがタイムアウトしたことを示すために使用されます。
    SUBSCRIPTION_INVALIDATE_OPERATION = 10

    # サブスクリプションヘッダーの追加または削除の際に、サブトピックとセレクタを区切るのに使用される区切り文字です。
    SUBTOPIC_SEPARATOR = "_;_"

    # これは、新規の CommandMessage インスタンスのデフォルトの操作です。 
    UNKNOWN_OPERATION = 10000

    # この操作は、リモート宛先からのサブスクライブ解除に使用します。 
    UNSUBSCRIBE_OPERATION = 1


    def __init__(self, *args, **kwargs):
        AsyncMessage.__init__(self, *args, **kwargs)
        self.operation = kwargs.get('operation', self.UNKNOWN_OPERATION)


class RemotingMessage(AbstractMessage):
    """
    RemotingMessages は、RPC 要求をリモートエンドポイントに送信するために使用されます。 このメッセージは operation プロパティを使って、リモートオブジェクトで呼び出すメソッドを指定します。 destination プロパティは、どのオブジェクトまたはサービスを使用するかを示します。 
    """

    def __init__(self, *args, **kwargs):
        AbstractMessage.__init__(self, *args, **kwargs)
        self.operation = kwargs.get('operation', None)
        self.source = kwargs.get('source', None)

