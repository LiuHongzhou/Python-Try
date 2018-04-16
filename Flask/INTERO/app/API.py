# APIS
def creatAPI(apiManager, API_PREFIX):
    from dbORM import User, Post, Question, Project, PostComment, QuestionComment, ProjectComment, Field, PostTag, ProjectTag, QuestionTag, Notification, Message
    from moduleLogin import post_create_auth_func, post_patch_auth_func, post_patch_many_auth_func

    apiManager.create_api(User, methods=["GET", "POST"], url_prefix=API_PREFIX, exclude_columns=["password"])
    apiManager.create_api(Post, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(Question, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(Project, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(PostComment, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(QuestionComment, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(ProjectComment, methods=["GET", "POST", "PATCH"], url_prefix=API_PREFIX, preprocessors = {"POST":[post_create_auth_func], "PATCH_SINGLE":[post_patch_auth_func], "PATCH_MANY":[post_patch_many_auth_func]}, exclude_columns=["User.password"])
    apiManager.create_api(Field, methods=["GET"], url_prefix=API_PREFIX)
    apiManager.create_api(PostTag, methods=["GET"], url_prefix=API_PREFIX)
    apiManager.create_api(ProjectTag, methods=["GET"], url_prefix=API_PREFIX)
    apiManager.create_api(QuestionTag, methods=["GET"], url_prefix=API_PREFIX)
    apiManager.create_api(Notification, methods=["GET", "POST"], url_prefix=API_PREFIX, exclude_columns=["from.password", "to.password"])
    apiManager.create_api(Message, methods=["GET", "POST"], url_prefix=API_PREFIX, exclude_columns=["from.password", "to.password"])
