if(NO_USERMANUAL)
	message(STATUS "building without usermanual")
	add_definitions(-DNO_USERMANUAL)
else()
	list(APPEND QT_EXTRA_COMPONENTS WebKitWidgets)
endif()
